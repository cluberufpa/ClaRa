# D05_abalone_biometria — Abalones adultos: biometria e peso

- Código: D05. Objeto definitivo: `abalone_adultos`. Origem EAPADados: `abalone_adultos`.
- Dimensões: 2641 × 9. Unidade: abalone adulto do recorte preexistente.
- Natureza: medição real, conforme origem; limites abaixo.
- Referência: Nash, Sellers, Talbot, Cawthorn e Ford (1994); UCI Abalone, DOI 10.24432/C55C7W.
- Licença: CC BY 4.0. A licença MIT do código não relicencia os dados.
- Situação: provisório; migração autorizada pelo professor em 11/10/2026.

## Linhas, colunas e de-para

Todas as linhas, colunas, ordem e ausências preservadas. Nenhuma seleção nova,
imputação ou conversão de unidade. Classe normalizada para data.frame sem
remover fatores ou datas. Codificação Latin-1 como no D01.

De-para: identidade; nenhuma mudança nova de nomes ou categorias.

Fontes congeladas em `fonte/`, com SHA256: objeto do EAPADados, documentação
roxygen e `abalone_bruto_uci.csv`. O preparo verifica hashes e dimensões.
A documentação herdada preserva o histórico das adaptações já aplicadas.

## Uso didático

## Conferência da passada 1

O recorte anterior foi reconstituído somente para conferência a partir do
CSV UCI: mesmas 2.641 linhas, 9 colunas, ordem, sexo e medidas. Mantidos os
filtros preexistentes e o fator 200 do preparo herdado, sem aplicar novas
exclusões. O xz ocupa 26.096 bytes; `data/` soma 39.952 bytes com catálogo.
Ajuda gerada; 240 expectativas passaram, zero falhas, erros, avisos ou skips.
Persistiu a falha preexistente no encerramento do processo R.

## Análises

Estatística descritiva; Histograma; Boxplot; Regressão linear simples. Verbo: relacionar_variaveis.

## Pendências para a curadoria

Conferir a restauração de unidades e o recorte herdados. Nenhuma nova seleção foi aplicada.

Instalação e check completo serão conferidos ao fim do bloco. Falhas do
ambiente R não serão contornadas com mudanças nas funções da ClaRa.
