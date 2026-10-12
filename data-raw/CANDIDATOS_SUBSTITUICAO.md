# Busca de substitutos — orientação para a curadoria (11/10/2026)

Atualização de 12/10/2026: os oito conjuntos do FSAdata e `MASS::crabs`
foram convertidos para leitura na hora na branch dados (v0.15.0), mantendo
nomes e códigos. A lista histórica abaixo identifica procedência, não cópias
que devam ser recriadas. As demais buscas não foram alteradas nesta rodada.
Relatório: `docs/LEITURA_DADOS_PACOTES_20261012.md`.

O professor informou que busca fontes para substituir parte dos dados
de pacotes ou menos relacionados a bioecologia geral, bioecologia pesqueira,
pesca, aquicultura e tecnologia do pescado. Esta é uma lista de trabalho,
com substituições aprovadas registradas abaixo. O catálogo mantém 60 conjuntos.
As prioridades abaixo são sugestões para avaliação do professor.

## Prioridade por distância temática

| Registro e objeto | Tema atual | O que procurar na fonte substituta |
|---|---|---|
| D12 bacterias_tratamento | Tratamento clínico em crianças | Resposta binária observada nos mesmos organismos em dois ou mais momentos, com ID, tratamento e tempo; pares para McNemar |
| D46 carros_frenagem | Frenagem de carros históricos | Duas medidas contínuas em organismos/ambiente aquático, suficientes para comparar curva linear e quadrática; replicação identificada |
| D47 terremotos_fiji | Geofísica | Estações ou ocorrências aquáticas reais com coordenadas, convenção geográfica explícita e quantidade para pontos/bolhas |
| D50 molinesias_parasitos | Bioecologia de peixes | Resolvido: substituição do quine aprovada em 11/10/2026, fonte Dryad CC0; curadoria fina pendente |
| D51 seguros_sinistros | Seguros de automóveis | Contagens agregadas com denominador/esforço observado e grupos; preservar exercício de exposição/offset |
| D52 paciente_peso | Série de peso humano | Série de crescimento ou redução de massa com tempo, unidade e organismo identificados, adequada a curva não linear e com dependência documentada |
| D53 navios_incidentes | Danos em frota sem identificação como pesqueira | Captura ou incidentes em embarcações/atividade pesqueira com esforço/exposição e fatores claros |

## Avaliar conforme o alcance de bioecologia geral

D11 (reação enzimática), D42 (crescimento de plantas), D44 (absorção de CO2),
D45 (insetos) e D48 (laranjeiras) têm fenômenos biológicos reais. Não foram
classificados automaticamente como fora do domínio amplo indicado.
D43 (ervilhas), D49 (aveia) e D60 (trigo) são exemplos de planejamento em
agricultura; fontes aquáticas seriam mais próximas do curso, preservando,
respectivamente, fatorial fracionado em blocos, parcelas subdivididas e
quadrado latino. D17 (salmouras) e D18 (nutrição de cabritos), herdados do
EAPADados, também podem entrar na avaliação temática. Nenhum foi removido.

## Pacote de origem não decide sozinho a qualidade

Dados de peixes distribuídos por FSAdata, QFASA e outros pacotes podem ser
reais, bem documentados e adequados ao tema. Preferir a fonte primária quando
acessível ajuda a esclarecer licença, delineamento, unidades e filtros;
trocar o arquivo distribuidor sem obter novas informações não resolve isso.
D54 merece atenção pela reconstrução aproximada de figura, mesmo estando
plenamente no tema pesqueiro. D59 está no tema, mas precisa esclarecer
espécie, área e construção do índice. Ambos preservados como provisórios.

Entradas cuja origem do catálogo declara diretamente um pacote R:

| Código | Objeto | Origem |
|---|---|---|
| D11 | puromicina_reacao | datasets::Puromycin |
| D12 | bacterias_tratamento | MASS::bacteria, cópia preservada no levantamento |
| D42 | plantas_crescimento | datasets::PlantGrowth |
| D43 | ervilhas_adubacao | datasets::npk |
| D44 | plantas_absorcao_co2 | datasets::CO2 |
| D45 | insetos_inseticidas | datasets::InsectSprays |
| D46 | carros_frenagem | datasets::cars |
| D47 | terremotos_fiji | datasets::quakes |
| D48 | laranjeiras_crescimento | datasets::Orange |
| D49 | aveia_parcelas | MASS::oats |

| D51 | seguros_sinistros | MASS::Insurance |
| D52 | paciente_peso | MASS::wtloss |
| D53 | navios_incidentes | MASS::ships |
| D54 | haemulon_crescimento | FSAdata::WhiteGrunt2 |
| D55 | cabezon_maturidade | FSAdata::Cabezon |
| D56 | ruffe_biometria | FSAdata::RuffeSLRH92 |
| D57 | bighill_amostras | FSAdata::BGHRsample |
| D58 | bighill_peixes | FSAdata::BGHRfish |
| D59 | peixes_recrutamento | astsa::rec |
| D60 | trigo_quadrado_latino | agridat::cochran.latin |

O quadro não pretende listar todas as reexportações indiretas pelo
EAPADados; essas têm procedência detalhada nas fichas e fontes congeladas.

## Critérios para avaliar cada nova fonte

- Dados reais e licença que permita cópia; artigo, repositório e arquivo
  original identificáveis, com unidades e delineamento documentados.
- Estrutura que preserve a finalidade didática: unidade experimental,
  grupos, pares, blocos, repetições, exposição ou calendário conforme o caso.
- Não fabricar réplicas a partir de médias, não atribuir coordenadas ou
  esforço inexistentes e não converter desconhecidos em respostas observadas.
- Avaliar tamanho final em rda/xz: data/ até 3 MB e autorização do professor
  antes de incorporar um conjunto acima de 100 KB.
- Substituição com decisão registrada; não renomear silenciosamente objetos
  definitivos já consumidos nem alterar a Trilha nesta sessão.
- Continuam autorizados somente treino_coletas e treino_desembarque como
  sintéticos para preparar dados e testar funcionalidades do menu.

Esta lista organiza a busca do professor; não registra uma busca na internet
nem afirma que novas fontes já foram encontradas ou validadas.

## Substituição aprovada em 11/10/2026

D50 agora é `molinesias_parasitos`, registro `D50_molinesias_parasitos`, fonte Dryad CC0. Substitui `MASS::quine` com autorização do professor. D45/InsectSprays permanece à espera de uma fonte experimental adequada. Parecer em `docs/AVALIACAO_MOLINESIAS_20261011.md`.
