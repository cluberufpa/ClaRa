# Bloco 1 — preparado, check pendente da passada 1 (11/10/2026)

Dez conjuntos preparados e registrados na branch `dados`, com um commit
por conjunto. O D01 já estava na main no formato D001; o ajuste do registro
está na branch. Os outros nove são incorporações provisórias. A main ainda
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
| D10 | enobieta_baci | 135 × 94 | 6.936 |

Total de `data/`, incluindo catálogo: **53.388 bytes (0,053 MB)**.
Todos os arquivos individuais ficaram abaixo de 100 KB. Compressão xz
conferida com `tools::checkRdaFiles()` após cada preparo.

## Conferências

- Documentação gerada em cada incorporação; suíte completa executada a
  cada conjunto. No estado final: **277 expectativas, zero falhas,
  erros, avisos ou skips**.
- Dez exemplos das ajudas executados; hashes SHA256 das fontes conferidos.
- Valores, ordem e ausências preservados. Aplicada a decisão anterior
  de sexo `femea` → `fêmea` nos pinguins. Corrigidas somente descrições
  de escalas do Doubs conforme ajuda original, sem converter valores.
- Build aprovado. O professor autorizou acrescentar os arquivos novos ao
  Collate; nove inclusões realizadas, sem mudar ordem anterior, versão ou
  dependências. O erro de arquivos ausentes foi resolvido.
- **Check repetido: 1 ERROR na instalação**, agora em `byte-compile and
  prepare package for lazy loading`: `lazy loading failed for package clara`.
  Nenhum erro específico de dados é exibido pelo instalador. O bloco ainda
  não atende à meta de check e não foi levado à main.
- Persistiu também a falha preexistente do processo R no encerramento,
  código -1073741819, depois de gravar os resultados de sucesso. Não
  equivale a aprovação da instalação ou do check.

### Diagnóstico isolado do ambiente

R básico com `--vanilla` encerrou com código 0. Carregar apenas `dplyr`
1.2.1, `rlang` 1.3.0, `vctrs` 0.7.3, `tibble` 3.3.1 ou `tidyselect` 1.2.1
reproduziu o código Windows 3221225477 (equivalente a -1073741819), sem
carregar a ClaRa ou seus dados. Isso localiza uma reprodução independente
no ambiente de pacotes; não estabelece a causa interna da falha nativa.

Foram baixadas cópias binárias novas de `dplyr` 1.2.1 e `rlang` 1.3.0 do
CRAN para uma biblioteca temporária fora do repositório. A conferência MD5
da instalação passou, mas a reprodução persistiu com ambas. A biblioteca
global, o R instalado e os outros projetos não foram alterados. A simples
reinstalação desses dois pacotes na mesma versão não resolveu o bloqueio.

Logs, resultados de testes, tarball e diretório de check ficam na pasta
temporária `verificacao-clara` deste chat, fora do repositório. Resíduos
antigos foram movidos de `data-raw/validacao/` para uma pasta temporária.
Nenhuma função da ClaRa, teste de análise ou arquivo da Trilha foi alterado.

## Decisões e seleção do Enobieta

O professor autorizou as inclusões no Collate. Ao questionar a expansão de
60 entradas para 69 objetos, pediu conferir o uso previsto para o Enobieta.
O balanço do levantamento o selecionou para estudo de caso e planejamento
prospectivo BACI, não como exigência de publicar todas as tabelas como objetos.

Foi incorporada a tabela de macroinvertebrados como `enobieta_baci` (D10),
com todas as 135 linhas e 94 colunas preservadas. As 2.700 linhas da tabela
de substrato continuam no XLSX integral da fonte, sem objeto adicional.
Whitefish e mesocosmos terão suas tabelas avaliadas pelo uso selecionado ao
chegar sua vez; não está autorizada uma expansão automática para 69 objetos.

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
- D10: uma intervenção e uma campanha por fase; subamostras não são barragens
  independentes. Taxonomia e escores IASPT para revisão; fonte organizada
  preservada, sem reextração do XLSX original nesta passada.

O balanço foi atualizado somente nas colunas de acompanhamento dos dez
conjuntos, com status de branch provisória e identificadores D01-D10.
Decisões anteriores, estilos e demais abas foram preservados; nenhum
conjunto foi marcado como concluído ou incluído como pronto enquanto o
check estiver pendente. A cópia anterior está em `acompanhamento/`.
