"""Atualiza só as colunas de acompanhamento, sem regravar estilos do Excel."""
from pathlib import Path
import json, shutil, zipfile, re, sys
from html import escape
import xml.etree.ElementTree as E

pacote = Path(__file__).resolve().parents[1]
balanco = pacote.parent / 'EAPADados/nova_estetegia_levantamento/balanco_fase2_60_conjuntos.xlsx'
integrado = '--integrado' in sys.argv[2:]
if len(sys.argv) not in (2, 3) or (len(sys.argv) == 3 and not integrado):
    raise SystemExit('Uso: python data-raw/atualizar_acompanhamento.py caminho/do/relatorio_de_verificacao.json [--integrado]')
relatorio = Path(sys.argv[1])
linhas = json.loads(relatorio.read_text(encoding='utf-8'))['catalogo']
por_nome = {r['nome_eapadados'] or r['nome']: r for r in linhas}
for r in linhas:
    origem = re.match(r'^([A-Za-z0-9.]+::[A-Za-z0-9._]+)', r.get('origem', ''))
    if origem:
        por_nome[origem.group(1)] = r
backup = pacote / 'data-raw/acompanhamento/balanco_antes_passada1_20261011.xlsx'
if not backup.exists():
    shutil.copyfile(balanco, backup)
ns = {'m': 'http://schemas.openxmlformats.org/spreadsheetml/2006/main'}
uri = ns['m']
E.register_namespace('', uri)
with zipfile.ZipFile(balanco) as z:
    arquivos = {i.filename: (i, z.read(i.filename)) for i in z.infolist()}
strings = []
if 'xl/sharedStrings.xml' in arquivos:
    strings = [''.join(x.itertext()) for x in E.fromstring(arquivos['xl/sharedStrings.xml'][1]).findall('m:si', ns)]
rels = {x.attrib['Id']: x.attrib['Target'] for x in E.fromstring(arquivos['xl/_rels/workbook.xml.rels'][1])}

def texto(c):
    v = c.find('m:v', ns)
    if c.attrib.get('t') == 's' and v is not None:
        return strings[int(v.text)]
    s = c.find('m:is', ns)
    return ''.join(s.itertext()) if s is not None else v.text if v is not None else ''

mudancas = {}
def escrever(row, coluna, valor):
    ref = coluna + row.attrib['r']
    mudancas[ref] = valor

alterados = []
modificados = set()
originais = {nome: dados for nome, (_, dados) in arquivos.items()}
for aba in E.fromstring(arquivos['xl/workbook.xml'][1]).findall('m:sheets/m:sheet', ns):
    if aba.attrib['name'] not in ('Núcleo 60', 'Inventário'):
        continue
    destino = rels[aba.attrib['{http://schemas.openxmlformats.org/officeDocument/2006/relationships}id']]
    nome_xml = destino.lstrip('/') if destino.startswith('/') else 'xl/' + destino
    xml = E.fromstring(arquivos[nome_xml][1]); rows = xml.findall('m:sheetData/m:row', ns)
    mudancas = {}
    cab = {texto(c): re.sub(r'\d', '', c.attrib['r']) for c in rows[0]}
    col_situacao = cab['Situação na ClaRa']
    col_codigo = next(v for k, v in cab.items() if k.startswith('Identificador ClaRa'))
    escrever(rows[0], col_codigo, 'Identificador ClaRa (Dxx)')
    for row in rows[1:]:
        c = next((c for c in row if c.attrib['r'] == 'A' + row.attrib['r']), None)
        nome = texto(c) if c is not None else ''
        if nome not in por_nome:
            continue
        r = por_nome[nome]
        situacao = ('Registro D01 ajustado na branch dados; main ainda com D001; autorização e check pendentes'
                    if r['codigo'] == 'D01' else 'Passada 1 provisória na branch dados; check e merge pendentes')
        if integrado:
            situacao = ('Integrado na main como D01; autorização da fonte e check pendentes'
                        if r['codigo'] == 'D01' else 'Passada 1 provisória integrada na main; check pendente')
        if r['nome_eapadados'] == 'walleye_erie' and r['nome'] == 'cowichan_amostragem':
            situacao += '; fonte substituída por cowichan_amostragem com autorização do professor'
        escrever(row, col_situacao, situacao)
        escrever(row, col_codigo, r['codigo'])
        alterados.append(aba.attrib['name'] + '!' + col_codigo + row.attrib['r'])
    # Trocar só células por texto; não reserializar o XML da aba, pois isso
    # pode remover declarações de namespaces usadas pelas extensões do Excel.
    conteudo = arquivos[nome_xml][1].decode('utf-8')
    for ref, valor in mudancas.items():
        padrao = r'<c\b(?=[^>]*\br="' + re.escape(ref) + r'")([^>]*?)(?:/>|>.*?</c>)'
        encontrado = re.search(padrao, conteudo, re.S)
        atributos = re.sub(r'\s+t="[^"]*"', '', encontrado.group(1)) if encontrado else ' r="' + ref + '"'
        nova = '<c' + atributos + ' t="inlineStr"><is><t>' + escape(valor) + '</t></is></c>'
        if encontrado:
            conteudo = conteudo[:encontrado.start()] + nova + conteudo[encontrado.end():]
        else:
            numero = re.search(r'\d+', ref).group()
            linha = re.search(r'<row\b(?=[^>]*\br="' + numero + r'")[^>]*>.*?</row>', conteudo, re.S)
            assert linha, ref
            fim = linha.end() - len('</row>')
            conteudo = conteudo[:fim] + nova + conteudo[fim:]
    E.fromstring(conteudo)  # Confirmar XML válido antes da gravação.
    arquivos[nome_xml] = (arquivos[nome_xml][0], conteudo.encode('utf-8'))
    modificados.add(nome_xml)
temporario = balanco.with_name('balanco_acompanhamento_temporario.xlsx')
with zipfile.ZipFile(temporario, 'w') as z:
    for info, dados in arquivos.values():
        z.writestr(info, dados)
# Os estilos, extensões, demais abas e decisões do autor são preservados.
with zipfile.ZipFile(temporario) as depois:
    for nome, dados in originais.items():
        if nome not in modificados:
            assert dados == depois.read(nome), nome
temporario.replace(balanco)
print(json.dumps({'celulas_identificador': alterados, 'estilos_preservados': True, 'conclusoes_marcadas': 0}, ensure_ascii=True))
