# Leitura na hora: não grava observações no pacote nem recria a cópia antiga.
# Executar na raiz da ClaRa, com a versão em desenvolvimento carregada.
bighill_amostras <- clara::carregar_dados("bighill_amostras")
stopifnot(identical(dim(bighill_amostras), c(20L, 4L)))
