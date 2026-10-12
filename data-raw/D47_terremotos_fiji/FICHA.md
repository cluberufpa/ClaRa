# D47 — Terremotos: localização de eventos próximos de Fiji

- Registro: `D47_terremotos_fiji`; objeto definitivo: `terremotos_fiji`; nome_eapadados: ``.
- Dimensões: 1000 × 5; unidade: evento sísmico de uma subamostra de mil eventos.
- Natureza: real conforme documentação do pacote; origem: datasets::quakes.
- Referência: Harvard PRIM-H, dados fornecidos por John Woodhouse, Department of Geophysics, Harvard; datasets::quakes.
- Licença: GPL-2 | GPL-3, conforme datasets (R 4.6.1). A licença MIT do código não altera a da fonte.
- Situação: provisório.

## Linhas e de-para

Todas as linhas e sua ordem preservadas. Ausências mantidas; nenhuma imputação.
lat → latitude_graus; long → longitude_graus; depth → profundidade_km; mag → magnitude; stations → estacoes_detectoras. Nenhuma linha excluída, reordenada ou simulada; zeros e ausências preservados. Sem conversão de unidades. Casca data.frame simples; estrutura de medidas repetidas explicada na ficha, sem atributos de groupedData que referenciem cabeçalhos antigos.

As fontes usadas no preparo estão preservadas integralmente em `fonte/`, com SHA256. Objeto primário recapturado da distribuição R/MASS e comparado à cópia do levantamento, antes das adaptações. Exceção D44: o levantamento guardava outro objeto; correção da fonte registrada em fonte/CORRECAO_FONTE.md. Não houve reextração independente das publicações históricas.

## Uso didático

Mapas de pontos; Bolhas proporcionais; Estatística descritiva. Principal: Mapas de pontos. Exemplo da ajuda resume os dados; não promete que a ClaRa tenha motor para todas as análises listadas.

## Pendências para a curadoria

Subamostra de 1.000 de 5.000 eventos, com critério de magnitude da fonte e ocorrências desde 1964; não é censo mundial ou série temporal com datas. Longitudes originais maiores que 180 graus preservadas; confirmar convenção ao mapear. A ajuda usa MB e Richter; não reinterpretar como magnitude de momento. Eventos próximos podem ter dependência espacial. Tema geofísico para ensinar mapas, sem contexto pesqueiro inventado.
