# D61 — Larvas de peixes: captura e esforço

Inclusão e arrumação autorizadas pelo professor em 12/10/2026.
Registro `D61_larvas_captura`; objeto `larvas_peixes_captura`; 58 × 7.
Novo registro: D51 e D53 continuam disponíveis, sem reutilização de códigos.

## Fonte e licença

Dale, Katherine; Pilch, Elena; Gomes, Mary; Laszlo, Nora; Mercer, Adam;
Mehta, Rita (2025). Using light traps to assess larval fish and octopus
paralarvae diversity and ontogenetic structure around Santa Catalina Island, CA.
[Dryad](https://datadryad.org/dataset/doi:10.7291/D1S38T).
[Artigo](https://doi.org/10.5343/bms.2024.0135).

CC0 1.0, no campo `license` dos metadados do repositório, preservados em
`fonte/light_metadata.json`. A licença MIT do código não altera a da fonte.
CSV recebido do professor; SHA-256 idêntico ao registrado pelo Dryad.
Fonte integral em `fonte/`, sem alteração. `preparar.R` confere o hash.

## Unidade, seleção e de-para

Evento de captura em armadilha luminosa nas enseadas de Santa Catalina,
Califórnia, EUA. Larvas de várias espécies somadas por evento. Todos os eventos,
sua ordem e suas contagens são mantidos, inclusive zeros e capturas extremas.
Sem imputação, simulação, agregação ou filtro por abundância.

| Origem | Destino | Tratamento |
|---|---|---|
| sample | id_evento | texto original |
| date_deployed | data | m/d/Y convertido para Date |
| site | local | BFC → Big Fisherman's Cove; CH → Cat Harbor; TH → Two Harbors |
| season | estacao | Spring → Primavera; Summer → Verão |
| year | ano | fator, 2018 e 2019 |
| soak_hours + soak_min/60 | esforco_h | horas por armadilha, sem arredondar a fração |
| n_fish | numero_larvas | inteiro, contagem multiespecífica |

Os nomes próprios dos locais permanecem. As estações são do hemisfério norte.
O esforço exato varia de 8 h 10 min a 18 h 50 min; a fonte decimal arredondada
informa 8,17–18,83 h. Diferença máxima de 0,2 minuto. A mudança é documentada,
não uma correção de tempo de coleta. A CPUE fica para o aluno calcular.

Saem do objeto: coordenada norte/sul e proteção (determinadas pelo local),
componentes redundantes de calendário/tempo, volume de plâncton, taxas prontas
e cefalópodes. Continuam acessíveis na fonte preservada. A soma de cefalópodes
no CSV é 207 e o resumo informa 205; não usar essa resposta sem esclarecer.

## Uso didático e limites

Poisson e binomial negativa com offset de esforço; exploração de CPUE.
O catálogo não promete uma função ClaRa de regressão de contagem.
Pergunta: como a taxa de captura de larvas por hora varia entre enseadas e
estações do ano, considerando o ano amostrado?

Há 15.919 larvas, oito zeros (13,79%) e um evento com 5.739 larvas (36,1% do total).
Não excluir o evento sem evidência de erro. A forte superdispersão de um GLM
de Poisson não dispensa conferir influência, resíduos e dependência temporal.
Primavera somente em 2019; ano × estação é incompleto. Não estimar efeitos
independentes de proteção ou orientação com locais confundidos com esses fatores.
O offset supõe proporcionalidade captura–tempo; isso precisa de avaliação.

## Validação

Hash, dimensões, tipos, categorias, datas, contagens e duração conferidos no
preparo e nos testes. Nenhuma linha descartada. Consulta exploratória anterior:
`TRILHA/docs/prompts_busca/resultados/04_captura_esforco_offset/RESULTADO_BUSCA.md`.
O preparo é reproduzível e a ajuda registra as limitações. Revisão final do
roteiro de ensino e da inferência temporal permanece com o autor.

Conferência em 12/10/2026: roxygen2 gerou a ajuda; testes gerais com
659 expectativas aprovadas, zero falhas e zero avisos; oito testes externos
omitidos porque FSAdata não está instalado. Os 21 testes do novo conjunto
passaram. Instalação em biblioteca temporária e carregamento em sessão limpa
por `carregar_dados("larvas_peixes_captura")` concluídos. Objeto xz: 900 bytes;
pasta data/: 222.660 bytes, abaixo do limite de 3 MB. Não foi executado
R CMD check completo nesta inclusão isolada. Alterações locais na branch
`dados`, em `ClaRa-dados/`; sem merge ou publicação no GitHub nesta sessão.
