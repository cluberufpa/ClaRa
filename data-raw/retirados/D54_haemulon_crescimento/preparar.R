# Leitura na hora: não grava observações no pacote nem recria a cópia antiga.
# Executar na raiz da ClaRa, com a versão em desenvolvimento carregada.
haemulon_crescimento <- clara::carregar_dados("haemulon_crescimento")
stopifnot(identical(dim(haemulon_crescimento), c(465L, 3L)))
