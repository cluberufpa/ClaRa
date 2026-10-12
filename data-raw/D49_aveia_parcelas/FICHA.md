# D49 — Aveia: variedades e nitrogênio em parcelas subdivididas

- Registro: `D49_aveia_parcelas`; objeto definitivo: `aveia_parcelas`; nome_eapadados: ``.
- Dimensões: 72 × 4; unidade: subparcela de 1/80 acre, aninhada em parcela principal e bloco.
- Natureza: real conforme documentação do pacote; origem: MASS::oats.
- Referência: Yates (1935), Complex experiments, Journal of the Royal Statistical Society Supplement 2:181–247; Yates (1970); Venables e Ripley (2002); MASS::oats.
- Licença: GPL-2 | GPL-3, conforme MASS 7.3-65. A licença MIT do código não altera a da fonte.
- Situação: provisório.

## Linhas e de-para

Todas as linhas e sua ordem preservadas. Ausências mantidas; nenhuma imputação.
B → bloco; V → variedade; N → dose_nitrogenio; Y → producao_quartos_libra. Nenhuma linha excluída, reordenada ou simulada; zeros e ausências preservados. Sem conversão de unidades. Casca data.frame simples; estrutura de medidas repetidas explicada na ficha, sem atributos de groupedData que referenciem cabeçalhos antigos.

As fontes usadas no preparo estão preservadas integralmente em `fonte/`, com SHA256. Objeto primário recapturado da distribuição R/MASS e comparado à cópia do levantamento, antes das adaptações. Exceção D44: o levantamento guardava outro objeto; correção da fonte registrada em fonte/CORRECAO_FONTE.md. Não houve reextração independente das publicações históricas.

## Uso didático

Planejamento em parcelas subdivididas; ANOVA com estratos de erro. Principal: Planejamento em parcelas subdivididas. Exemplo da ajuda resume os dados; não promete que a ClaRa tenha motor para todas as análises listadas.

## Pendências para a curadoria

Seis blocos, três parcelas principais por bloco e quatro subparcelas por parcela. Variedade atribuída à parcela principal; nitrogênio à subparcela. Não usar o mesmo erro para ambos os fatores nem ANOVA de dois fatores simples como se fossem 72 unidades independentes. Preservadas doses categóricas cwt/acre e produção em quartos de libra; não converter sem definir o padrão de cwt. Nomes de cultivares são próprios e permanecem originais.
