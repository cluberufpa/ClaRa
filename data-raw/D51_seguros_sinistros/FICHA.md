# D51 — Seguros: sinistros e número de segurados

- Registro: `D51_seguros_sinistros`; objeto definitivo: `seguros_sinistros`; nome_eapadados: ``.
- Dimensões: 64 × 5; unidade: célula agregada de distrito, classe do automóvel e faixa etária.
- Natureza: real conforme documentação do pacote; origem: MASS::Insurance.
- Referência: Baxter, Coutts e Ross (1980), Applications of linear models in motor insurance, 21st International Congress of Actuaries, Zurich:11–29; Aitkin et al. (1989); MASS::Insurance.
- Licença: GPL-2 | GPL-3, conforme MASS 7.3-65. A licença MIT do código não altera a da fonte.
- Situação: provisório.

## Linhas e de-para

Todas as linhas e sua ordem preservadas. Ausências mantidas; nenhuma imputação.
District → distrito; Group → classe_cilindrada; Age → faixa_etaria; Holders → numero_segurados; Claims → sinistros. Nenhuma linha excluída, reordenada ou simulada; zeros e ausências preservados. Sem conversão de unidades. Casca data.frame simples; estrutura de medidas repetidas explicada na ficha, sem atributos de groupedData que referenciem cabeçalhos antigos. Classes numéricas de cilindrada e idade preservadas, inclusive ordered; não são palavras inglesas a traduzir.

As fontes usadas no preparo estão preservadas integralmente em `fonte/`, com SHA256. Objeto primário recapturado da distribuição R/MASS e comparado à cópia do levantamento, antes das adaptações. Exceção D44: o levantamento guardava outro objeto; correção da fonte registrada em fonte/CORRECAO_FONTE.md. Não houve reextração independente das publicações históricas.

## Uso didático

Modelos de contagem; Poisson com exposição e offset. Principal: Modelos de contagem. Exemplo da ajuda resume os dados; não promete que a ClaRa tenha motor para todas as análises listadas.

## Pendências para a curadoria

Contagens agregadas do terceiro trimestre de 1973, não linhas individuais de segurados. Considerar numero_segurados como exposição; não inventar pessoas-ano ou assumir que cada segurado tem no máximo um sinistro. Preservados os fatores ordenados das classes de automóvel e idade, e limites originais. Distrito 4 corresponde a grandes cidades, demais identidades não informadas. Diagnosticar dispersão; catálogo não implica motor de GLM disponível na ClaRa.
