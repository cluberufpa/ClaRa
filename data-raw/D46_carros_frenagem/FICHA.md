# D46 — Carros: velocidade e distância de parada

- Registro: `D46_carros_frenagem`; objeto definitivo: `carros_frenagem`; nome_eapadados: ``.
- Dimensões: 50 × 2; unidade: registro histórico de velocidade e distância de parada de automóvel.
- Natureza: real conforme documentação do pacote; origem: datasets::cars.
- Referência: Ezekiel (1930), Methods of Correlation Analysis; McNeil (1977); dados coletados na década de 1920; datasets::cars.
- Licença: GPL-2 | GPL-3, conforme datasets (R 4.6.1). A licença MIT do código não altera a da fonte.
- Situação: provisório.

## Linhas e de-para

Todas as linhas e sua ordem preservadas. Ausências mantidas; nenhuma imputação.
speed → velocidade_mph; dist → distancia_parada_ft. Nenhuma linha excluída, reordenada ou simulada; zeros e ausências preservados. Sem conversão de unidades. Casca data.frame simples; estrutura de medidas repetidas explicada na ficha, sem atributos de groupedData que referenciem cabeçalhos antigos.

As fontes usadas no preparo estão preservadas integralmente em `fonte/`, com SHA256. Objeto primário recapturado da distribuição R/MASS e comparado à cópia do levantamento, antes das adaptações. Exceção D44: o levantamento guardava outro objeto; correção da fonte registrada em fonte/CORRECAO_FONTE.md. Não houve reextração independente das publicações históricas.

## Uso didático

Regressão linear; Modelo quadrático; Comparação de curvas. Principal: Regressão linear. Exemplo da ajuda resume os dados; não promete que a ClaRa tenha motor para todas as análises listadas.

## Pendências para a curadoria

Preservadas as unidades originais: milhas por hora e pés, sem conversão. São dados históricos, inadequados para recomendar distâncias de segurança atuais. Não presumir medições independentes em carros diferentes; protocolo e identidade dos veículos a revisar. Não extrapolar curvas além do intervalo observado.
