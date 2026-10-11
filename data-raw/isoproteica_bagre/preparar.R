# Bagres: da fonte preservada ao conjunto da ClaRa.
# Rode a partir da raiz de ClaRa-dados, depois de instalar readxl,
# digest e usethis. Esses pacotes de preparo não são dependências dos dados.

pasta <- file.path("data-raw", "isoproteica_bagre")
fonte <- normalizePath(file.path(pasta, "fonte", "dados_brutos_eapadados.xlsx"),
                       winslash = "/", mustWork = TRUE)
manifesto <- readLines(file.path(pasta, "fonte", "SHA256.txt"))
hash <- strsplit(manifesto[grepl("  dados_brutos_eapadados.xlsx$", manifesto)],
                 "  ", fixed = TRUE)[[1]][1]
bytes <- readBin(fonte, what = "raw", n = file.info(fonte)$size)
stopifnot(identical(digest::digest(bytes, algo = "sha256", serialize = FALSE), hash))

# Lemos apenas a aba dos bagres. Não usamos a planilha de revisão como fonte.
brutos <- readxl::read_excel(fonte, sheet = "src_isoproteica")
stopifnot(nrow(brutos) == 19L, ncol(brutos) == 2L)

# A, B, C e D são categorias nominais, nessa ordem de apresentação.
# Cada peso é a média final de uma gaiola, segundo a documentação recebida.
# Não são pesos individuais nem ganho de peso; não calculamos valores novos.
D001_bagre_racao_isoproteica <- data.frame(
  racao = factor(brutos[[1]], levels = c("A", "B", "C", "D")),
  peso_medio_final_g = as.double(brutos[[2]])
)

# Comparamos também com o objeto anterior: só os nomes e a classe da tabela
# mudaram. Repetições legítimas e ordem das observações são preservadas.
anterior <- new.env(parent = emptyenv())
load(file.path(pasta, "fonte", "isoproteica_bagre.rda"), envir = anterior)
stopifnot(
  identical(dim(D001_bagre_racao_isoproteica), c(19L, 2L)),
  !anyNA(D001_bagre_racao_isoproteica),
  identical(as.integer(table(D001_bagre_racao_isoproteica$racao)), c(5L, 5L, 4L, 5L)),
  identical(as.character(D001_bagre_racao_isoproteica$racao),
            as.character(anterior$isoproteica_bagre$racao)),
  identical(D001_bagre_racao_isoproteica$peso_medio_final_g,
            as.double(anterior$isoproteica_bagre$peso_g)),
  identical(as.double(tapply(D001_bagre_racao_isoproteica$peso_medio_final_g,
                            D001_bagre_racao_isoproteica$racao, sum)),
            c(431, 444, 410, 463))
)

usethis::use_data(D001_bagre_racao_isoproteica, overwrite = TRUE, compress = "xz")
