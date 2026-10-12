# D53 — Navios: incidentes e exposição ao serviço

- Registro: `D53_navios_incidentes`; objeto definitivo: `navios_incidentes`; nome_eapadados: ``.
- Dimensões: 40 × 5; unidade: célula agregada de tipo de navio, período de construção e operação.
- Natureza: real conforme documentação do pacote; origem: MASS::ships.
- Referência: McCullagh e Nelder (1983), Generalized Linear Models, seção 6.3.2, p. 137; MASS::ships.
- Licença: GPL-2 | GPL-3, MASS 7.3-65. A licença MIT do código não altera a da fonte.
- Situação: provisório.

## Linhas e de-para

Todas as linhas e sua ordem preservadas. Ausências mantidas; nenhuma imputação.
type → tipo_navio; year → periodo_construcao; period → periodo_operacao; service → servico_meses; incidents → incidentes. Códigos year 60/65/70/75 e period 60/75 expandidos para intervalos categóricos da ajuda. Exposição zero permanece na base; filtro só no ramo analítico com offset. Todas as linhas e sua ordem preservadas, sem imputação, exclusão ou simulação. Unidades originais mantidas.

As fontes usadas no preparo estão preservadas integralmente em `fonte/`, com SHA256. A conferência compara o objeto do levantamento com a fonte da distribuição do pacote, antes das adaptações documentadas. Não houve reextração independente das publicações históricas.

## Uso didático

Poisson; Modelos de contagem com exposição/offset. Principal: Poisson. Exemplo da ajuda resume os dados; não promete que a ClaRa tenha motor para todas as análises listadas.

## Pendências para a curadoria

Quarenta células agregadas de frota, não 40 navios individuais. Seis células com serviço zero preservadas; log(servico_meses) só pode ser aplicado no ramo de análise após tratar a exposição zero. Não retirar zeros da base. Períodos são intervalos categóricos, não anos pontuais. A ajuda não diz que são embarcações pesqueiras. Avaliar dispersão, sem assumir estimativas herdadas de Poisson/NB. Candidato à substituição por incidentes ou capturas com esforço/exposição no domínio pesqueiro.
