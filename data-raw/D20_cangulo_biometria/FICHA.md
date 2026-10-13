# D20 — Cangulo: relação peso-comprimento

- Registro: `D20_cangulo_biometria`; objeto: `cangulo_crescimento`; nome_eapadados: `cangulo_crescimento`.
- Fonte identificada em 13/10/2026: **Tabela 11.2** de Ivo, C. T. C.; Fonteles Filho, A. A. (1997), *Estatística pesqueira: aplicação em Engenharia de Pesca*, Fortaleza, Tom Gráfica e Editora, vi + 193 p.: "Valores do comprimento total (cm) e peso total (g) do cangulo, *Balistes vetula*, no Estado do Ceará". Transcrição em `fonte/tabela_11_2_ivo_fonteles_1997.csv`; detalhes em `fonte/PROVENIENCIA.md`.
- Dimensões: 16 × 7; unidade: peixe, três por classe de comprimento de 2 cm (12 a 42 cm), 48 pesos ao todo.
- Licença: uso didático na Trilha e na ClaRa com citação da obra, sem termo de consentimento (decisão do professor, 13/10/2026). Sem licença pública.
- Situação: revisado (fonte e valores conferidos com o livro).

## Colunas (de-para em 13/10/2026)

| Coluna | Antes | No livro |
|---|---|---|
| `comprimento_cm` | `comprimento_cm` | Comprimento (x) |
| `peso1_g`, `peso2_g`, `peso3_g` | `p1`, `p2`, `p3` | Peso (g): y1, y2, y3 |
| `peso_medio_g` | `peso_g` | Média dos pesos (y) |
| `ln_comprimento` | `ln_peso` na cópia herdada (nome trocado) | x' = ln x |
| `ln_peso_medio` | `ln_comp` na cópia herdada (nome trocado) | y' = ln y |

Comprimentos e pesos idênticos ao livro. A média e os logaritmos têm todas as casas; o livro dá uma ou três e, na classe de 36 cm, trunca a média (1015,2; a conta dá 1015,27).

## Uso didático

Relação peso-comprimento: a reta `ln_peso_medio ~ ln_comprimento` dá b = 2,86 (alometria negativa, perto de 3). O livro ajusta às 16 médias; empilhando `peso1_g` a `peso3_g` (largo para longo), a mesma reta usa os 48 peixes, e o aluno vê a diferença entre ajustar médias e indivíduos. Verbo ClaRa: `relacionar_variaveis()` nas colunas de logaritmo.

## Pendências

Ano e método de coleta não constam da tabela.

Reproduzir na raiz: `source("data-raw/D20_cangulo_biometria/preparar.R")`.
