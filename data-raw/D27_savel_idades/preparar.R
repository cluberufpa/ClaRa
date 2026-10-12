# Leitura na hora: não grava observações no pacote nem recria a cópia antiga.
# Executar na raiz da ClaRa, com a versão em desenvolvimento carregada.
idades_savel_repetibilidade <- clara::carregar_dados("idades_savel_repetibilidade")
stopifnot(identical(dim(idades_savel_repetibilidade), c(53L, 8L)))
