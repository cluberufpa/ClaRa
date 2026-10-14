# D38 — Truta-de-riacho: ração, temperatura e crescimento

- Registro: `D38_truta_crescimento`; objeto definitivo: `truta_riacho_crescimento`; nome_eapadados: `truta_riacho_crescimento`.
- Dimensões: 69 × 8; unidade: peixe individual agrupado em tanque.
- Natureza: real; origem: EAPADados::truta_riacho_crescimento.
- Referência: Rutledge, Nislow, Fuller, McCormick, Chen e Chadwick (2025), Dryad, DOI 10.5061/dryad.v6wwpzh86.
- Licença: CC0-1.0. A licença MIT do código não altera a da fonte.
- Situação: provisório.

## Linhas e de-para

Todas as linhas e sua ordem preservadas. Ausências mantidas; nenhuma imputação.
Cabeçalhos, categorias, valores e ordem herdados preservados; nenhuma exclusão nova.

As fontes usadas no preparo estão preservadas integralmente em `fonte/`, com SHA256. A conferência compara o objeto herdado com a planilha/CSV que o originou, antes das adaptações autorizadas. Uma fonte local organizada não equivale a reextração independente de toda a publicação.

## Uso didático

Pseudorreplicação: médias por tanque; fatorial 2 x 2 (temperatura x ração) no tanque. Principal: agregar os peixes por tanque. A ANCOVA saiu daqui em 13/10/2026 e passou para D15 e D16. Exemplo da ajuda resume os dados; não promete que a ClaRa tenha motor para todas as análises listadas.

## Pendências para a curadoria

Preservado o subconjunto herdado de 69 peixes, já sem ração zero. Ração/temperatura são compartilhadas por tanque: não tratar os 69 indivíduos como réplicas independentes dos tratamentos. Confirmar alocação e número de tanques por combinação. eficiencia_conversao pode incorporar a própria resposta; não a usar como preditor sem revisar a fórmula. high/low preservados, tradução ainda pendente.

## Unidade experimental (13/10/2026)

Os 69 peixes estão em sete tanques, e temperatura e ração foram aplicadas ao tanque: a unidade experimental é o tanque. Compare as médias dos tanques, não os peixes. O fatorial 2 x 2 é desbalanceado (22 °C com ração alta tem um só tanque). A ANCOVA foi tirada daqui; para ela, use D15 ou D16.
