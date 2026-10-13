# D12 — Erva-marinha: aparecimento de lesões

- Registro: `D12_erva_lesoes`; objeto: `erva_marinha_lesoes`.
- Substitui `bufalos_estrongilos`, mantendo D12 e o exercício de McNemar.
- Fonte: Murray, DuBois e Stachowicz (2024), *Journal of Ecology*, DOI 10.1111/1365-2745.14312; dados Dryad DOI 10.25338/B8805V. Licença CC0 1.0, conferida em 12/10/2026.
- 180 linhas, cinco colunas, 90 plantas focais e dois momentos por planta. A unidade é a planta focal, não o mesocosmo inteiro.
- `tratamento`: `controle`, `dano_artificial` ou `isopode_herbivoro`. Os códigos brutos `Con`, `Clip` e `Bug` são traduzidos na receita.
- A fonte registra a cobertura de lesão final de cada uma das três plantas focais (`AFTER_p1` a `AFTER_p3`) em 30 mesocosmos. Essas plantas iniciaram limpas por delineamento; por isso a receita registra cobertura e presença de lesão iguais a zero no momento `antes`. Não é imputação: é a condição experimental declarada para essas plantas.
- `presenca_lesao` é 0 quando a cobertura é zero e 1 quando há qualquer lesão. Nos 90 pares, 21 permaneceram sem lesão e 69 passaram de ausência a presença. Não há reversões, portanto a comparação descreve surgimento de lesões, não cura.
- `cobertura_lesao_pct` preserva a resposta contínua em porcentagem, inclusive para explorar magnitude depois da tabela binária.
- Limites: as três plantas de um mesmo mesocosmo compartilham condições; não devem ser apresentadas como 90 unidades experimentais independentes para comparar tratamentos. O pareamento antes/depois é individual, mas a inferência sobre tratamento exige reconhecer o agrupamento por mesocosmo.
- Reproduzir na raiz: `source("data-raw/D12_erva_lesoes/preparar.R")`.
