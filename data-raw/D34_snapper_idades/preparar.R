# Leitura na hora: não grava observações no pacote nem recria a cópia antiga.
# Executar na raiz da ClaRa, com a versão em desenvolvimento carregada.
snapper_hg <- clara::carregar_dados("snapper_hg")
stopifnot(identical(dim(snapper_hg), c(1331L, 6L)))
