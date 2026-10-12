# D50 — Escolares: dias de ausência em Walgett

- Registro: `D50_escolares_ausencias`; objeto definitivo: `escolares_ausencias`; nome_eapadados: ``.
- Dimensões: 146 × 5; unidade: criança com número de dias ausente em um ano escolar.
- Natureza: real conforme documentação do pacote; origem: MASS::quine.
- Referência: S. Quine, citado em Aitkin (1978), The analysis of unbalanced cross classifications, Journal of the Royal Statistical Society A 141:195–223; Venables e Ripley (2002); MASS::quine.
- Licença: GPL-2 | GPL-3, conforme MASS 7.3-65. A licença MIT do código não altera a da fonte.
- Situação: provisório.

## Linhas e de-para

Todas as linhas e sua ordem preservadas. Ausências mantidas; nenhuma imputação.
Eth → origem_cultural; Sex → sexo; Age → etapa_escolar; Lrn → classe_aprendizagem; Days → dias_ausencia. Categorias de origem_cultural: A → aborigene, N → nao_aborigene. Categorias de sexo: F → feminino, M → masculino. Categorias de etapa_escolar: F0 → primario, F1 → F1, F2 → F2, F3 → F3. Categorias de classe_aprendizagem: AL → aprendizagem_media, SL → aprendizagem_lenta. Nenhuma linha excluída, reordenada ou simulada; zeros e ausências preservados. Sem conversão de unidades. Casca data.frame simples; estrutura de medidas repetidas explicada na ficha, sem atributos de groupedData que referenciem cabeçalhos antigos.

As fontes usadas no preparo estão preservadas integralmente em `fonte/`, com SHA256. Objeto primário recapturado da distribuição R/MASS e comparado à cópia do levantamento, antes das adaptações. Exceção D44: o levantamento guardava outro objeto; correção da fonte registrada em fonte/CORRECAO_FONTE.md. Não houve reextração independente das publicações históricas.

## Uso didático

Modelos de contagem; Binomial negativa; Superdispersão. Principal: Modelos de contagem. Exemplo da ajuda resume os dados; não promete que a ClaRa tenha motor para todas as análises listadas.

## Pendências para a curadoria

Dados observacionais históricos de Walgett, Nova Gales do Sul; classificações culturais e de aprendizagem são as da fonte, não diagnósticos atuais nem medidas de capacidade. Não interpretar associações como efeitos causais de origem cultural. Age é etapa escolar, não idade em anos. Confirmar equivalência de forms F1/F2/F3 antes de tradução adicional. Não há número de dias de exposição por criança; não inventar offset.
