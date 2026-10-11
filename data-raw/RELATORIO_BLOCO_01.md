# Bloco 1 — parcial da passada 1 (11/10/2026)

Nove conjuntos preparados e registrados na branch `dados`, com um commit
por conjunto. O D01 já estava na main no formato D001; o ajuste do registro
está na branch. Os outros oito são incorporações provisórias. A main ainda
não recebeu este bloco; nenhuma versão foi aumentada e não houve push.

| Código | Objeto definitivo | Dimensões | Bytes xz |
|---|---|---|---:|
| D01 | bagre_racao_isoproteica | 19 × 2 | 292 |
| D02 | morfometria_barbo | 100 × 13 | 7.536 |
| D03 | cpue_tubarao | 424 × 5 | 3.376 |
| D04 | doubs_ambiente | 30 × 13 | 1.112 |
| D05 | abalone_adultos | 2.641 × 9 | 26.096 |
| D06 | salvelino_formalina_remocao | 30 × 7 | 696 |
| D07 | camarao_vannamei_biometria | 170 × 9 | 1.588 |
| D08 | pinguins | 344 × 8 | 2.380 |
| D09 | tilapia_sensorial | 122 × 7 | 848 |

Total de `data/`, incluindo catálogo: **46.216 bytes (0,046 MB)**.
Todos os arquivos individuais ficaram abaixo de 100 KB. Compressão xz
conferida com `tools::checkRdaFiles()` após cada preparo.

## Conferências

- Documentação gerada em cada incorporação; suíte completa executada a
  cada conjunto. No estado final: **271 expectativas, zero falhas,
  erros, avisos ou skips**.
- Nove exemplos das ajudas executados; hashes SHA256 das fontes conferidos.
- Valores, ordem e ausências preservados. Aplicada a decisão anterior
  de sexo `femea` → `fêmea` nos pinguins. Corrigidas somente descrições
  de escalas do Doubs conforme ajuda original, sem converter valores.
- Build parcial aprovado. **Check parcial com 1 ERROR na instalação:**
  oito arquivos novos `R/dados_*.R` estão ausentes do Collate do DESCRIPTION.
  O roxygen avisa, mas não grava as inclusões. Campo mantido intacto porque
  o prompt o proíbe; solicitada autorização para acrescentar só esses nomes.
- Persistiu também a falha preexistente do processo R no encerramento,
  código -1073741819, depois de gravar os resultados de sucesso. Não
  equivale a aprovação da instalação ou do check.

Logs, resultados de testes, tarball e diretório de check ficam na pasta
temporária `verificacao-clara` deste chat, fora do repositório. Resíduos
antigos foram movidos de `data-raw/validacao/` para uma pasta temporária.
Nenhuma função da ClaRa, teste de análise ou arquivo da Trilha foi alterado.

## Decisões necessárias para fechar o bloco

1. Autorizar acrescentar exclusivamente os novos arquivos de documentação
   ao Collate, preservando sua ordem atual, versão e dependências. A restrição
   está na seção "Seu espaço de trabalho" do prompt atualizado:
   "Não mexa em versão, Imports nem Collate". A necessidade está demonstrada
   pelo erro de instalação acima. Sem a inclusão, os dados não são instaláveis.
2. Enobieta tem duas tabelas, whitefish quatro e mesocosmos seis, com unidades
   distintas. Recomendação submetida ao professor: uma tabela por conjunto,
   com nomes e registros próprios, sem descartar nenhuma; resultariam 69
   objetos para as 60 entradas do levantamento. A alternativa é manter
   listas de tabelas, adaptando o catálogo e sua validação. Enobieta ainda
   não foi incorporado; nenhum código definitivo lhe foi atribuído.

## Pendências de curadoria

- D01: autorização dos autores e descrição da replicação.
- D02: conferir a correção alométrica completa; rio/população são colineares.
- D03: créditos, licença, unidade da CPUE e desenho da coleta não localizados.
- D04: manter escalas originais explícitas e licença da fonte; propor coluna
  de identificação para os rownames de estações na passada 2.
- D05: revisar unidades e critérios do recorte herdados, sem novos filtros.
- D06: desenho desequilibrado, pressupostos e transformação da resposta.
- D07: denominação anatômica do comprimento, cefalotórax ausente no DB1.
- D08: manter ausências; selecionar casos completos somente na análise.
- D09: âncoras e sentido da escala; conferir extração contra o depósito original.

O balanço foi atualizado somente nas colunas de acompanhamento dos nove
conjuntos, com status de branch provisória e identificadores D01-D09.
Decisões anteriores, estilos e demais abas foram preservados; nenhum
conjunto foi marcado como concluído ou incluído como pronto enquanto o
check estiver pendente. A cópia anterior está em `acompanhamento/`.
