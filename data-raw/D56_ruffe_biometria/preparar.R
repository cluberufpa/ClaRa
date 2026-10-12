# Leitura na hora: não grava observações no pacote nem recria a cópia antiga.
# Executar na raiz da ClaRa, com a versão em desenvolvimento carregada.
ruffe_biometria <- clara::carregar_dados("ruffe_biometria")
stopifnot(identical(dim(ruffe_biometria), c(738L, 11L)))
