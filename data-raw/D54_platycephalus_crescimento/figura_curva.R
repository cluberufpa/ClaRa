# Executar na raiz da ClaRa, com a ClaRa carregada (devtools::load_all()).
# Figura de conferência: curva de von Bertalanffy por sexo, a mesma da ficha (recorte de 402 peixes).
d <- platycephalus_crescimento[!is.na(platycephalus_crescimento$comprimento_cm), ]
vb <- function(dd) nls(comprimento_cm ~ Linf * (1 - exp(-K * (idade_anos - t0))),
                       data = dd, start = list(Linf = 50, K = 0.3, t0 = 0))
cor_sexo <- c(femea = "#E76F51", macho = "#2E7D8F")
png("docs/D54_platycephalus_curva.png", width = 1000, height = 650, res = 110)
par(mar = c(4.2, 4.2, 3, 1))
plot(jitter(d$idade_anos, 1), jitter(d$comprimento_cm, 0.5), pch = 16, cex = 0.4,
     col = cor_sexo[as.character(d$sexo)],
     xlab = "Idade (anos)", ylab = "Comprimento (cm)",
     main = "Tiger flathead (Platycephalus richardsoni): arrasto de 2000, área EBS")
idades <- seq(2, 16, 0.1)
for (s in names(cor_sexo)) {
  ajuste <- vb(d[which(d$sexo == s), ])
  lines(idades, predict(ajuste, data.frame(idade_anos = idades)), lwd = 3, col = cor_sexo[[s]])
}
legend("bottomright", c("fêmeas (252)", "machos (150)"), pch = 16, col = cor_sexo, bty = "n")
dev.off()
