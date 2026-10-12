> Atualização após conciliação de registros (12/10/2026): o catálogo consolidado contém 62 conjuntos (53 internos, oito FSAdata, um MASS). D61 é anchova-do-norte; larvas de peixes passam a D62. Quantidades anteriores abaixo são históricas. Ver docs/CONCILIACAO_D61_D62_20261012.md.

## D44 e D48 — substituições autorizadas em 12/10/2026

`percas_hipoxia` substitui `plantas_absorcao_co2` (D44); `molinesias_crescimento` substitui `laranjeiras_crescimento` (D48). Respectivamente, 449 medições de 40 peixes (Dryad/Zenodo, CC0) e 1178 medições de 34 peixes (Figshare, CC BY 4.0). Todos os valores observados e os NA da resposta das percas foram preservados. Os registros antigos estão em `data-raw/substituidos/`; nomes antigos saem do catálogo ativo. O total permanece em 61 registros. Fichas e ajudas explicam dependência, cobertura e limites dos grupos. A incorporação não acrescenta motores de medidas repetidas ou curvas não lineares à ClaRa.

# Atualização — D47, coordenadas de pesca (12/10/2026)

`pollock_alasca` substitui `terremotos_fiji` no D47: NOAA/DisMAP CC0,
523 lances de 2023, coordenadas WGS84, CPUE e profundidade. Substituição
autorizada pelo professor; fonte antiga preservada no histórico.
Dois pontos costeiros mantidos e identificados na ficha para conferência;
os 54 estratos são códigos, não uma escala numérica. Catálogo: 61 registros.

# Atualização — larvas com esforço (12/10/2026)

Incluído `D61_larvas_captura`, objeto `larvas_peixes_captura`: fonte Dryad CC0, 58 eventos, esforço variável e contagens de larvas. Cobre a necessidade didática de offset de D51/D53; os dois registros antigos permanecem, pois a autorização foi para incluir. Catálogo atual com 61 registros. Veja a ficha do D61 para delineamento incompleto e dependência temporal.

# Busca de substitutos — orientação para a curadoria (11/10/2026)

Atualização de 12/10/2026: os oito conjuntos do FSAdata e `MASS::crabs`
foram convertidos para leitura na hora na branch dados (v0.15.0), mantendo
nomes e códigos. A lista histórica abaixo identifica procedência, não cópias
que devam ser recriadas. As demais buscas não foram alteradas nesta rodada.
Relatório: `docs/LEITURA_DADOS_PACOTES_20261012.md`.

O professor informou que busca fontes para substituir parte dos dados
de pacotes ou menos relacionados a bioecologia geral, bioecologia pesqueira,
pesca, aquicultura e tecnologia do pescado. Esta é uma lista de trabalho,
com substituições aprovadas registradas abaixo. O catálogo tem 53 conjuntos (44 internos, oito do FSAdata e um do MASS), depois das retiradas de 12/10/2026 (D11, D42, D43, D45, D46, D49, D51, D53 e D59), após a inclusão do D61 e do D62.
As prioridades abaixo são sugestões para avaliação do professor.

## Prioridade por distância temática

| Registro e objeto | Tema atual | O que procurar na fonte substituta |
|---|---|---|
| D12 bacterias_tratamento | Tratamento clínico em crianças | Resolvido: `bufalos_estrongilos` (CC0, 418 linhas) mantém pares e linhas sem par para McNemar |
| D46 carros_frenagem | Frenagem de carros históricos | Duas medidas contínuas em organismos/ambiente aquático, suficientes para comparar curva linear e quadrática; replicação identificada |
| D47 pollock_alasca | Pesca de pesquisa | Resolvido: NOAA CC0, 523 lances; substituição aprovada em 12/10/2026. Dois pontos costeiros a conferir |
| D50 molinesias_parasitos | Bioecologia de peixes | Resolvido: substituição do quine aprovada em 11/10/2026, fonte Dryad CC0; curadoria fina pendente |
| D51 seguros_sinistros | Seguros de automóveis | Contagens agregadas com denominador/esforço observado e grupos; preservar exercício de exposição/offset |
| D52 paciente_peso | Série de peso humano | Resolvido: `secagem_beterraba_gengibre` (CC BY 4.0, 594 linhas); unidade do tempo e códigos B/G, C/E seguem pendentes |
| D53 navios_incidentes | Danos em frota sem identificação como pesqueira | Captura ou incidentes em embarcações/atividade pesqueira com esforço/exposição e fatores claros |

## Avaliar conforme o alcance de bioecologia geral

D11 (reação enzimática), D42 (crescimento de plantas),
e D45 (insetos) têm fenômenos biológicos reais. Não foram
classificados automaticamente como fora do domínio amplo indicado.
D43 (ervilhas), D49 (aveia) e D60 (trigo) são exemplos de planejamento em
agricultura; fontes aquáticas seriam mais próximas do curso, preservando,
respectivamente, fatorial fracionado em blocos, parcelas subdivididas e
quadrado latino. D17 (salmouras), herdado do EAPADados, permanece na avaliação temática.
D18 foi substituído por `truta_acidos_graxos` em 12/10/2026: sete dietas,
21 aquários, semana 12 e fonte Mendeley Data CC BY 4.0. Fontes dos cabritos
preservadas apenas como histórico.

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
| D11 (retirado) | puromicina_reacao | datasets::Puromycin; retirado do pacote, fonte em data-raw/retirados |
| D12 (histórico) | bacterias_tratamento, substituído por bufalos_estrongilos | MASS::bacteria, fonte antiga em data-raw/substituidos |
| D42 (retirado) | plantas_crescimento | datasets::PlantGrowth; retirado do pacote, fonte em data-raw/retirados |
| D43 (retirado) | ervilhas_adubacao | datasets::npk; retirado do pacote, fonte em data-raw/retirados |
| D44 (histórico) | plantas_absorcao_co2, substituído por percas_hipoxia | datasets::CO2, fonte antiga em data-raw/substituidos |
| D45 (retirado) | insetos_inseticidas | datasets::InsectSprays; retirado do pacote, fonte em data-raw/retirados |
| D46 (retirado) | carros_frenagem | datasets::cars; retirado do pacote, fonte em data-raw/retirados |
| D47 (histórico) | terremotos_fiji, substituído por pollock_alasca | datasets::quakes, fonte antiga arquivada |
| D48 (histórico) | laranjeiras_crescimento, substituído por molinesias_crescimento | datasets::Orange, fonte antiga em data-raw/substituidos |
| D49 (retirado) | aveia_parcelas | MASS::oats; retirado do pacote, fonte em data-raw/retirados |

| D51 (retirado) | seguros_sinistros | MASS::Insurance; retirado do pacote, fonte em data-raw/retirados |
| D52 (histórico) | paciente_peso, substituído por secagem_beterraba_gengibre | MASS::wtloss, fonte antiga em data-raw/substituidos |
| D53 (retirado) | navios_incidentes | MASS::ships; retirado do pacote, fonte em data-raw/retirados |
| D54 | haemulon_crescimento | FSAdata::WhiteGrunt2 |
| D55 | cabezon_maturidade | FSAdata::Cabezon |
| D56 | ruffe_biometria | FSAdata::RuffeSLRH92 |
| D57 | bighill_amostras | FSAdata::BGHRsample |
| D58 | bighill_peixes | FSAdata::BGHRfish |
| D59 (retirado) | peixes_recrutamento | astsa::rec; retirado do pacote, fonte em data-raw/retirados |
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

## Substituições de 12/10/2026 (fusão das branches)

D12 (`bufalos_estrongilos`) e D52 (`secagem_beterraba_gengibre`) vieram da
branch `codex/substitutos-literatura-20261012`; D44 (`percas_hipoxia`) e D48
(`molinesias_crescimento`, 1.178 medições) ficaram com os objetos da `dados`.
As variantes da outra branch estão em `data-raw/alternativas_codex/`, fora do
pacote. D51 (`seguros_sinistros`) e D53 (`navios_incidentes`) seguem no
catálogo mesmo com `larvas_peixes_captura` (D62) já incluído; a retirada deles
depende de decisão do professor. D04 (doubs) foi substituído em 12/10/2026 por `lago_vitoria` (Okechi et al. 2025, Dryad, CC0). Restam sem substituto: D42 e D45 (já retirados).
