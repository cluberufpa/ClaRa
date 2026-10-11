"""Prepara somente a cópia de revisão; não incorpora dados no pacote."""
from pathlib import Path
import csv
import hashlib
import shutil
from openpyxl import Workbook, load_workbook
from openpyxl.styles import Font, PatternFill, Alignment
from openpyxl.comments import Comment

PASTA = Path(__file__).resolve().parent
ORIGEM = PASTA.parents[3] / 'EAPADados/nova_estetegia_levantamento/levantamento_tecnico/literatura/artemia_fitos_esterols/Artemia_growth_sterols.csv'
FONTE = PASTA / 'fonte/artemia_real'
FONTE.mkdir(parents=True, exist_ok=True)
destino = FONTE / ORIGEM.name
shutil.copyfile(ORIGEM, destino)
assert hashlib.md5(destino.read_bytes()).hexdigest() == '3e4495f10c1cb70a73c73f00295ed467'
(FONTE / 'SHA256.txt').write_text(hashlib.sha256(destino.read_bytes()).hexdigest() + '  ' + destino.name + '\n', encoding='utf-8')
(FONTE / '.gitattributes').write_text('* -text\n', encoding='utf-8')
url = 'https://www.bco-dmo.org/dataset/724179'
metodos = url + '/description'
with destino.open(encoding='utf-8-sig', newline='') as f:
    linhas = list(csv.reader(f))
cabecalho = linhas[0]
dados = [r[:3] + [float(r[3]), float(r[4])] for r in linhas[1:]]
assert cabecalho == ['experiment', 'sterol_id', 'sterol_name', 'biomass_mg', 'ind_weight_ug']
assert len(dados) == 69 and all(len(r) == 5 for r in dados)
wb = Workbook()
readme = wb.active
readme.title = 'README'
informacoes = [
    ['Campo', 'Descrição'],
    ['Situação', 'Fonte real candidata para substituir artemia fictícia; ainda em curadoria. D002 proposto.'],
    ['Fonte', 'Hassett, R. P.; Giner, J. (2021). Effect of phytosterol supplementation on Artemia growth. BCO-DMO, versão 1 (2018-01-19). DOI: 10.26008/1912/bco-dmo.724179.1'],
    ['Página da fonte', url],
    ['Métodos e unidades', metodos],
    ['Licença dos dados', 'CC BY 4.0 — manter autoria, referência, licença e indicação das adaptações.'],
    ['Licença — endereço', 'https://creativecommons.org/licenses/by/4.0/'],
    ['Alimentação', 'Rhodomonas suplementada com esteróis; não são duas rações comerciais.'],
    ['Unidade experimental', 'Recipiente aerado de 4 L. Peso seco médio por indivíduo é uma resposta agregada por recipiente.'],
    ['Delineamento', 'Quatro experimentos; seis tratamentos nos três primeiros e cinco no quarto; três recipientes por tratamento. Não misturar experimentos para aumentar n.'],
    ['Medidas', 'biomass_mg: biomassa seca por recipiente em mg; ind_weight_ug: peso seco médio em µg/indivíduo. Não representam mg/dia.'],
    ['Teste t — proposta', 'Definir previamente dois tratamentos do mesmo experimento e uma resposta. Cada grupo terá três recipientes. Não escolher o par pelo p-valor. A fonte não informa pareamento.'],
    ['Base completa', 'Comparações entre os tratamentos de cada experimento podem servir à ANOVA, mediante avaliação dos pressupostos.'],
    ['Trilha', 'A fonte real exige ajuste do contrato atual: não renomear peso seco como taxa_crescimento_mg_dia. Nenhuma alteração feita na Trilha.'],
    ['Dados para revisar', '69 registros copiados do CSV, mesma ordem, cabeçalhos e categorias originais (inclusive espaços finais). Valores numéricos armazenados como números no Excel.'],
    ['Tratamentos', 'Lista de combinações distintas de experimento e suplemento, na ordem da fonte. Sem resultados dos testes.'],
    ['Como revisar', 'Edite somente as células azuis da aba Revisão do autor. Exemplo de anotação: “Quero revisar o experimento exp_2 antes de escolher dois suplementos”. Salve e avise no chat.'],
    ['Data da cópia', '11/10/2026'],
    ['Integridade', 'CSV original preservado em fonte/artemia_real; MD5 conferido com o repositório; SHA256 ao lado do arquivo.'],
]
for r in informacoes:
    readme.append(r)
raw = wb.create_sheet('Dados para revisar')
raw.append(cabecalho)
for r in dados:
    raw.append(r)
for c in raw[1]:
    c.comment = Comment('Fonte: ' + url + '; CSV Artemia_growth_sterols.csv. Cabeçalho original.', 'Fonte')
trat = wb.create_sheet('Tratamentos')
trat.append(cabecalho[:3])
vistos = set()
for r in dados:
    chave = tuple(r[:3])
    if chave not in vistos:
        trat.append(r[:3])
        vistos.add(chave)
dicionario = wb.create_sheet('Dicionario')
for r in [
    ['Coluna original', 'Nome proposto', 'Significado / decisão pendente'],
    ['experiment', 'experimento', 'Fator. Preservar quatro experimentos distintos.'],
    ['sterol_id', '(somente na fonte)', 'Identificador químico associado ao nome. Guardar correspondência na documentação; evitar coluna redundante no objeto didático.'],
    ['sterol_name', 'dieta', 'Fator: nome do suplemento da dieta. Preservar nomes químicos; remover somente espaços finais, após aprovação.'],
    ['biomass_mg', 'biomassa_seca_mg', 'Double, mg de biomassa seca por recipiente.'],
    ['ind_weight_ug', 'peso_seco_medio_ug', 'Double, µg por indivíduo; média por recipiente, não observações individuais.'],
]:
    dicionario.append(r)
revisao = wb.create_sheet('Revisão do autor')
for r in [
    ['Decisão', 'Anotação do professor'],
    ['Esta é a fonte real que você tinha em mente?', ''],
    ['Experimento a usar no exemplo de teste t', ''],
    ['Dois suplementos a comparar e motivo biológico', ''],
    ['Resposta: biomassa seca ou peso seco médio?', ''],
    ['Aprovar nomes propostos ou sugerir ajustes', ''],
    ['Outras observações', ''],
]:
    revisao.append(r)
for ws in wb:
    ws.freeze_panes = 'A2'
    ws.auto_filter.ref = ws.dimensions
    for row in ws:
        for c in row:
            c.font = Font(name='Arial', size=11)
            c.alignment = Alignment(vertical='top', wrap_text=True)
    for c in ws[1]:
        c.fill = PatternFill('solid', fgColor='0F3B5F')
        c.font = Font(name='Arial', size=11, color='FFFFFF', bold=True)
    ws.sheet_view.showGridLines = False
    ws.row_dimensions[1].height = 30
    ws.column_dimensions['A'].width = 34
    ws.column_dimensions['B'].width = 26
    ws.column_dimensions['C'].width = 48
    if ws in (readme, revisao):
        ws.column_dimensions['B'].width = 110
        for i in range(2, ws.max_row + 1):
            ws.row_dimensions[i].height = 56
    if ws == dicionario:
        ws.column_dimensions['C'].width = 95
        for i in range(2, ws.max_row + 1):
            ws.row_dimensions[i].height = 44
raw.column_dimensions['D'].width = 22
raw.column_dimensions['E'].width = 24
for i in range(2, revisao.max_row + 1):
    revisao.cell(i, 2).fill = PatternFill('solid', fgColor='DDEBF7')
    revisao.cell(i, 2).font = Font(name='Arial', size=11, color='0000FF')
arquivo = PASTA / 'artemia_real_para_revisao.xlsx'
wb.save(arquivo)
conferencia = load_workbook(arquivo)
assert list(conferencia['Dados para revisar'].values) == [tuple(cabecalho)] + [tuple(r) for r in dados]
assert not any(c.data_type == 'f' for ws in conferencia for row in ws for c in row)
print('Revisão criada e conferida: 69 registros, 5 colunas; CSV com MD5 idêntico ao da fonte pública.')
