# Leitura na hora: não grava observações no pacote nem recria a cópia antiga.
# Executar na raiz da ClaRa, com a versão em desenvolvimento carregada.
darter_ontario <- clara::carregar_dados("darter_ontario")
stopifnot(identical(dim(darter_ontario), c(54L, 3L)))
