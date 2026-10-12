# Leitura na hora: não grava observações no pacote nem recria a cópia antiga.
# Executar na raiz da ClaRa, com a versão em desenvolvimento carregada.
cabezon_maturidade <- clara::carregar_dados("cabezon_maturidade")
stopifnot(identical(dim(cabezon_maturidade), c(525L, 5L)))
