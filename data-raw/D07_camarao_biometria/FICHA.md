# D07_camarao_biometria — Camarão-branco: biometria e peso

- Código: D07. Objeto definitivo: `camarao_vannamei_biometria`. Origem EAPADados: `camarao_vannamei_biometria`.
- Dimensões: 170 × 9. Unidade: camarão medido, identificado por base e amostra.
- Natureza: medição real, conforme origem; limites abaixo.
- Referência: Ramírez-Coronel et al. (2024); Mendeley Data, versão 2, DOI 10.17632/h8tcn6ykky.2.
- Licença: CC BY 4.0. A licença MIT do código não relicencia os dados.
- Situação: provisório; migração autorizada pelo professor em 11/10/2026.

## Linhas, colunas e de-para

Todas as linhas, colunas, ordem e ausências preservadas. Nenhuma seleção nova,
imputação ou conversão de unidade. Classe normalizada para data.frame sem
remover fatores ou datas. Codificação Latin-1 como no D01.

De-para: identidade; nenhuma mudança nova de nomes ou categorias.

Fontes congeladas em `fonte/`, com SHA256: objeto do EAPADados, documentação
roxygen e `camarao_vannamei_biometria.csv`. O preparo verifica hashes e dimensões.
A documentação herdada preserva o histórico das adaptações já aplicadas.

## Uso didático

## Conferência da passada 1

Conferido com o CSV de origem em inst/extdata: 170 × 9, mesmas medidas,
identificadores, ordem e NA de cefalotórax. O xz ocupa 1.588 bytes;
`data/` soma 42.568 bytes com catálogo. Ajuda gerada; 255 expectativas
passaram, zero falhas, erros, avisos ou skips. Persistiu a falha
preexistente no encerramento do processo R.

## Análises

Regressão linear simples; Regressão não linear; Estatística descritiva. Verbo: relacionar_variaveis.

## Pendências para a curadoria

A fonte define LENGTH do rostro ao início da cauda; conferir o termo comprimento corporal total da ajuda herdada. Cefalotórax ausente no DB1; preservar NA e os cinco subconjuntos.

Instalação e check completo serão conferidos ao fim do bloco. Falhas do
ambiente R não serão contornadas com mudanças nas funções da ClaRa.
