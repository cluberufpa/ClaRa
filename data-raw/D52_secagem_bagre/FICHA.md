# D52 — Bagre-africano: curva de secagem a 80 °C

- Registro: `D52_secagem_bagre`; objeto: `secagem_bagre`.
- Ocupa o D52, vago desde a saída de `secagem_beterraba_gengibre` (vegetais) em 13/10/2026, por decisão do professor no mesmo dia. Escolhido na busca 14 da Trilha (`TRILHA/docs/prompts_busca/resultados/14_secagem_pescado/RESULTADO_BUSCA.md`), depois de não se acharem curvas de secagem de pescado com várias réplicas e licença aberta em repositórios e teses.
- Fonte: Ohijeagbon et al. (2018), *Data in Brief* 18:641–647, DOI 10.1016/j.dib.2018.03.072, CC BY 4.0. Colunas de 80 °C das Tabelas 1 e 2, conferidas valor a valor. Detalhes em `fonte/PROVENIENCIA.md`.
- Dimensões: 10 × 6; unidade: um lote de bagres-africanos (*Clarias gariepinus*) eviscerados, pesado de hora em hora, de 0 a 540 min, num secador a gás a 80 °C.
- Resposta principal: `massa_peixe_kg` (8,53 → 2,03 kg). Auxiliares: `temperatura_secador_c` (79,8 a 82,1 °C), `gas_consumido_kg` (por intervalo; vazio no tempo 0) e `energia_mj`, como publicados.
- Análise didática (teste da busca 14, R 4.6.1): com a massa relativa, `massa_peixe_kg / 8.53`, o modelo de Page, `exp(-(k * tempo)^n)`, vence a reta e o de Lewis (AIC −50,2; −43,1; −27,1); k = 0,00242 min⁻¹ e n = 1,42.
- Limites: uma só curva, sem réplicas, portanto não serve para comparar temperaturas. Com assíntota livre, o patamar estimado converge para zero; as dez pesagens não mostram um patamar físico, e não se deve extrapolar além de 540 min nem chamar o patamar de massa seca.
- `umidade_publicada` fica como no artigo, para discussão sobre documentação e dados derivados: o rótulo diz base seca, o valor inicial (0,770) parece base úmida e o final é 0,000. Ela não entra no ajuste.
- Ficaram de fora as curvas de 100 °C (9 pontos) e 120 °C (8 pontos) do mesmo artigo.
- Reproduzir na raiz: `source("data-raw/D52_secagem_bagre/preparar.R")`.
