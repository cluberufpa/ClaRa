# Resumo das sessões da ClaRa (3 a 9 de outubro de 2026)

Síntese das seis conversas do antigo grupo "ClaRa" do Claude. As decisões
vigentes estão no `CLAUDE.md` desta pasta; este arquivo conta o caminho e
guarda o que ainda depende do professor.

## O caminho, versão a versão

| Versão | O que entrou |
|---|---|
| 0.5 | `grafico_medias()` com `largura_barras`, `altura_rotulo` e `fonte` ("sans"/"serif"); rótulo "média ± DP" em pé, dentro da coluna; aviso com mais de 8 grupos; opções no Tab; `ajuda()` no painel Viewer (ou `onde = "console"`) |
| 0.6 | `clara.R` dividido em um arquivo por pergunta (`clara_medias.R`, `clara_medianas.R`, `clara_qualquer_analise.R`, `clara_motor.R`); `comparar_medianas()` (Mann-Whitney com Hodges-Lehmann; Kruskal-Wallis com Dunn/Holm escrito em dplyr; Fligner-Killeen como pressuposto) e `grafico_medianas()` |
| 0.7 | versão no cabeçalho de `R/clara.R` e em `versao_clara`, avisada no `source()`; projeto movido para `EAPA-Ecossistema/ClaRa` |
| 0.7.1 a 0.7.3 | intervalo do η²/ε² bilateral; `registrar_ambiente()`; `salvar_tabelas()` e `salvar_figuras()` com o nome do arquivo antes do `=` |
| 0.8.0 | ANOVA de Welch (`variancias_iguais = FALSE`); padrão `NULL` conforme o número de grupos |
| 0.8.2 a 0.8.9 | `escrever_resultados()` em redação de artigo: destaque (`"maior"`, `"menor"` ou grupo de referência), nota da tabela e legenda da figura geradas pela ClaRa, F e p em itálico, Tabela 1 citada depois do F, comparações sem repetir a frase das letras |

## Decisões que ficaram (todas já no CLAUDE.md)

- **A ClaRa é R de verdade:** funções em português, uma por pergunta, com o
  tidyverse visível só por `mostrar_codigo = TRUE`. O código mostrado,
  rodado sem a ClaRa, dá o mesmo resultado (é o teste de fechamento de cada
  análise).
- **Chamadas explícitas:** a mecânica fica escondida, mas o que se analisa e o
  que se salva aparece escrito; no exportador, as escolhas dos menus vão
  escritas mesmo quando são o padrão.
- **Um arquivo por pergunta, sem subpastas**, com `R/clara.R` como porta de
  entrada.
- **Uma análise por vez;** ideias do caminho vão para "Em espera".
- **Rota ClaRa do projeto exportado (ANOVA de um fator):** um só QMD (o Word),
  `R/analise.R` como caderno de estudo, base nascida da planilha numa só
  cadeia com pipe, carimbo com `stopifnot()` no número de linhas (sem `.rds`),
  `dados/` só com a planilha, base para o Excel em `saida/tabelas/base.csv`,
  ClaRa em `R/clara/`, só CRAN.
- **Letras com dois grupos e frase do poder observado:** mantidas.
- **Gráficos de diagnóstico:** `grafico_residuos()` e `grafico_qq()`
  separados ("uma função, uma figura").
- **Nome da IDE:** Trilha (pacote `trilha`). A cópia da ClaRa que viaja nos
  projetos mora em `TRILHA/inst/app/templates/clara/`; a CatalyseR foi
  encerrada na 0.1.34.

## Ainda em aberto

1. **Dunn:** escrito na receita (como hoje) ou de um pacote; Holm ou
   Bonferroni.
2. **Medianas:** limites de leitura do ε² e do r; se basta conferir a
   dispersão; mínimo de 3 por grupo.
3. **Comparar com um controle** (aprovado, a implementar): `comparacao` e
   `controle` em `comparar_medias()` e `comparar_medianas()`.
4. **Virar pacote ou não.** Às 12h04 de 8/10 a regra 4 foi revista: a ClaRa
   continua sem pacote, porque viaja como cópia na Trilha e o projeto
   exportado tem de ser só CRAN. Dez minutos depois, outra sessão
   ("ClaRa R package planning") recebeu do professor um pedido de plano de
   pacote, e o plano ficou **à espera de aprovação**, sem código migrado.
   Pontos principais do pedido e do plano:
   - três famílias: análise, redação (`relatar_*`, `interpretar_*`) e
     formatação (`flextable_ocean()`, formato de número e de p, tema), hoje
     espalhadas em três lugares (ClaRa, `funcoes*.R` da IDE e EAPADados),
     com até 11 cópias de `flextable_ocean()`;
   - o `relatorio.qmd` exportado continuaria em tidyverse, com a ClaRa só na
     formatação e na redação. Isso contraria a rota ClaRa atual, cujo
     relatório chama `comparar_medias()`;
   - público ampliado às ciências agrárias e biológicas, com vocabulário
     neutro (tratamento, unidade amostral, resposta, grupo);
   - pronto para um dia ir ao CRAN: o nome `ClaRa` está livre (há só a
     função `cluster::clara()`); riscos de ASCII nas strings, `library()`
     dentro de `executar_receita()`, `set.seed()` e arquivos gravados;
   - até 15 conjuntos de dados próprios, leves e com licença aberta, e uma
     página `?dados_sugeridos` com conjuntos de outros pacotes do CRAN;
   - sem `%in%`; `case_when()` no lugar de `if/else` aninhado; um comentário
     acima de cada linha nas funções principais.
   Decisões pendentes (A a I do plano): nome, nomes da formatação
   (`formatar_numero()`/`formatar_p()`), prefixo `exibir_*` ou `mostrar_*`,
   effectsize e flextable em Imports, escopo da redação na primeira versão,
   o `analise.R` da rota ClaRa, mantenedor no DESCRIPTION e a política de
   dados (fictícios? autorizações?).

## Outros trabalhos do período

- Aula "Do mouse ao código" (R, RStudio e o Projeto R exportado), em
  PowerPoint e Quarto, em `EAPA-Ecossistema/aulas-r-catalyser-2026/`; falta
  escolher o formato das próximas aulas (PPTX ou Quarto).
- Propostas de logo da Trilha, hoje em
  `TRILHA/docs/identidade_visual/Trilha/propostas/`; a IDE já usa
  `inst/app/www/logo_trilha_transparente.png`.
