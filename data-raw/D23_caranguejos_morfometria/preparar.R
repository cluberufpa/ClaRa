# Leitura na hora: não grava observações no pacote nem recria a cópia antiga.
# Executar na raiz da ClaRa, com a versão em desenvolvimento carregada.
crabs_morfometria <- clara::carregar_dados("crabs_morfometria")
stopifnot(identical(dim(crabs_morfometria), c(200L, 10L)))
