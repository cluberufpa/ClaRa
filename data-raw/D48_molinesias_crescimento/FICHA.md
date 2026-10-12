# D48 — Molinésias: crescimento individual

- Registro: `D48_molinesias_crescimento`; objeto: `molinesias_crescimento`.
- Substitui `laranjeiras_crescimento` (`datasets::Orange`) por decisão do professor em 12/10/2026, mantendo D48.
- Fonte: Scherer e colaboradores (2023), Figshare DOI 10.6084/m9.figshare.23971599.v1; licença CC BY 4.0, conferida em 12/10/2026.
- Recorte didático: 340 medições — os mesmos 34 peixes nas dez idades completas 0, 14, 21, 42, 49, 56, 77, 154, 224 e 280 dias. A fonte integral (1.178 linhas) permanece congelada.
- Colunas: `peixe`, `mae`, `idade_dias`, `comprimento_cm`. As categorias maternas são m1, m2 e m4, com 14, 4 e 16 peixes, respectivamente.
- `mae` não é tratamento: são mães aparentadas e não sustentam generalização de efeito materno. Cada peixe é acompanhado repetidamente; não tratar as 340 linhas como réplicas independentes.
- As predições e intervalos já calculados pela fonte não entram no objeto: a ClaRa deve ajustar e comparar suas próprias curvas a partir das medições observadas.
- Reproduzir na raiz: `source("data-raw/D48_molinesias_crescimento/preparar.R")`.
