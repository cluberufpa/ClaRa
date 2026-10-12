# Leitura na hora: não grava observações no pacote nem recria a cópia antiga.
# Executar na raiz da ClaRa, com a versão em desenvolvimento carregada.
bighill_peixes <- clara::carregar_dados("bighill_peixes")
stopifnot(identical(dim(bighill_peixes), c(266L, 6L)))
