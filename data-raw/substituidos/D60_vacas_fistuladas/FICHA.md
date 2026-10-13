# D60 — Vacas fistuladas: quadrado latino 4 × 4

- Registro: `D60_vacas_fistuladas`; objeto: `vacas_fistuladas`.
- Substitui `trigo_quadrado_latino` (agridat::cochran.latin), por decisão do professor em 12/10/2026: o trigo estava fora do contexto do ecossistema. O novo conjunto é de produção animal, transferível à aquicultura como ensaio de cruzamento de dietas.
- Fonte: Merino et al. (2021), *Animals* 11(4):919, DOI 10.3390/ani11040919; dados no Figshare, DOI 10.6084/m9.figshare.13818920.v3. CC BY 4.0, conferida em 12/10/2026. A busca e o parecer vieram do prompt 13 (Trilha); a conferência foi refeita à parte, com a ANOVA do artigo.
- 16 linhas (4 vacas × 4 períodos), 8 colunas: `id_vaca`, `periodo`, `oferta_forragem`, `suplemento`, `tratamento`, `ph_ruminal`, `nh3_n_mmol_l`, `agv_total_mmol_l`.
- É um quadrado latino 4 × 4 completo: cada dieta aparece uma vez em cada vaca e uma vez em cada período (a receita confere). As quatro dietas são as combinações de oferta de forragem (20 ou 30 kg de MS) e suplemento (milho úmido ou trigo moído): um fatorial 2 × 2 dentro do quadrado.
- Os sete horários de coleta de cada célula viraram a média. Usar os 112 valores brutos como independentes é pseudo-replicação (resíduo com 102 graus de liberdade em vez de 6).
- Resultado para conferir (pH): tratamento F = 0,18 (p = 0,90), vaca p = 0,69, período F = 13,1 (p = 0,005); erro médio de 0,080 (um fator) para 0,021 (quadrado). No modelo fatorial do artigo os p da oferta, do suplemento e da interação são 0,810, 0,856 e 0,528, iguais aos da Tabela 4.
- Os códigos 1/2 da planilha foram resolvidos pelas médias da Tabela 4 (oferta 1 = 20 kg; suplemento 1 = milho úmido). A receita compara as médias de pH, N-NH3 e AGV com o artigo.
- Limites: 4 vacas e 16 observações (6 graus de liberdade no resíduo), sem efeito de dieta; possível efeito residual entre períodos que o quadrado simples não controla; a AGV tinha 25 ausências no bruto.
- Para a aula: comparar a ANOVA de um fator (ignora vaca e período), a de blocos em uma direção e a do quadrado; mostrar o ganho do bloqueio de período; discutir a pseudo-replicação dos horários.
- Receita histórica: `source("data-raw/substituidos/D60_vacas_fistuladas/preparar.R")`. Ela recria o objeto antigo e substitui temporariamente o registro D60; não a execute para a versão ativa.
