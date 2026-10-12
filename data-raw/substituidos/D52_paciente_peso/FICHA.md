# D52 — Paciente: peso durante programa de redução

- Registro: `D52_paciente_peso`; objeto definitivo: `paciente_peso`; nome_eapadados: ``.
- Dimensões: 52 × 2; unidade: medição ao longo do tempo de um único paciente.
- Natureza: real conforme documentação do pacote; origem: MASS::wtloss.
- Referência: Dr. T. Davies, Adelaide; Venables e Ripley (2002), Modern Applied Statistics with S.; MASS::wtloss.
- Licença: GPL-2 | GPL-3, MASS 7.3-65. A licença MIT do código não altera a da fonte.
- Situação: provisório.

## Linhas e de-para

Todas as linhas e sua ordem preservadas. Ausências mantidas; nenhuma imputação.
Days → dias; Weight → peso_kg.  Todas as linhas e sua ordem preservadas, sem imputação, exclusão ou simulação. Unidades originais mantidas.

As fontes usadas no preparo estão preservadas integralmente em `fonte/`, com SHA256. A conferência compara o objeto do levantamento com a fonte da distribuição do pacote, antes das adaptações documentadas. Não houve reextração independente das publicações históricas.

## Uso didático

Curva exponencial assintótica; Regressão não linear. Principal: Curva exponencial assintótica. Exemplo da ajuda resume os dados; não promete que a ClaRa tenha motor para todas as análises listadas.

## Pendências para a curadoria

São 52 medições de um único paciente durante 246 dias; não são 52 pacientes independentes. Dias repetidos preservados. Não inferir efeito causal do programa ou generalizar a outros pacientes. Sem detalhes clínicos adicionais na ajuda. Candidato prioritário à substituição por série de crescimento ou perda de massa em contexto aquático, preservando a finalidade de ajuste não linear.
