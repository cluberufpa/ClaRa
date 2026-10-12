# D43 — Ervilhas: adubação NPK em blocos

- Registro: `D43_ervilhas_adubacao`; objeto definitivo: `ervilhas_adubacao`; nome_eapadados: ``.
- Dimensões: 24 × 5; unidade: parcela de 1/70 acre em experimento fatorial fracionado, com seis blocos.
- Natureza: real conforme documentação do pacote; origem: datasets::npk.
- Referência: Imperial College, London, folha de exercícios de mestrado; Venables e Ripley (2002); datasets::npk.
- Licença: GPL-2 | GPL-3, conforme datasets (R 4.6.1). A licença MIT do código não altera a da fonte.
- Situação: provisório.

## Linhas e de-para

Todas as linhas e sua ordem preservadas. Ausências mantidas; nenhuma imputação.
block → bloco; N → nitrogenio; P → fosfato; K → potassio; yield → producao_lb_parcela. Categorias de nitrogenio: 0 → nao_aplicado, 1 → aplicado. Categorias de fosfato: 0 → nao_aplicado, 1 → aplicado. Categorias de potassio: 0 → nao_aplicado, 1 → aplicado. Nenhuma linha excluída, reordenada ou simulada; zeros e ausências preservados. Sem conversão de unidades. Casca data.frame simples; estrutura de medidas repetidas explicada na ficha, sem atributos de groupedData que referenciem cabeçalhos antigos.

As fontes usadas no preparo estão preservadas integralmente em `fonte/`, com SHA256. Objeto primário recapturado da distribuição R/MASS e comparado à cópia do levantamento, antes das adaptações. Exceção D44: o levantamento guardava outro objeto; correção da fonte registrada em fonte/CORRECAO_FONTE.md. Não houve reextração independente das publicações históricas.

## Uso didático

Planejamento em blocos; Fatorial 2³ com confundimento. Principal: Planejamento em blocos. Exemplo da ajuda resume os dados; não promete que a ClaRa tenha motor para todas as análises listadas.

## Pendências para a curadoria

Não é um fatorial completo de oito combinações em cada bloco: são quatro parcelas por bloco. Metades do fatorial foram usadas em blocos diferentes e a interação NPK fica confundida com blocos. Respeitar o delineamento e termos estimáveis; não aplicar ANOVA simples ignorando blocos. Manter libras/parcela e confirmar procedência histórica do experimento.
