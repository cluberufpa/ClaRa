# Parecer: molinésias e parasitos

Avaliação de 11/10/2026. **Recomendação: aceitar como substituto didático de `MASS::quine`; continuar a busca para `datasets::InsectSprays`.** Decisão posterior do professor em 11/10/2026: substituição do quine autorizada, mantendo D50; incorporado como `molinesias_parasitos`, com curadoria fina provisória.

## Fonte e licença

O [registro do Dryad](https://datadryad.org/dataset/doi:10.5061/dryad.jsxksn0r9) confirma título, cinco autores e publicação em 6 de maio de 2026. No README incorporado, seção “Description of the data and file structure”, aparece o consentimento dos autores e contribuintes ao **CC0 waiver**. É evidência específica deste depósito. Registrar CC0 para os dados, com crédito à fonte, mantendo separada a licença MIT do código da ClaRa.

O [artigo de Sheehy e colaboradores](https://onlinelibrary.wiley.com/doi/full/10.1002/ece3.74288), *Ecology and Evolution* 16(9), e74288, publicado em 10 de setembro de 2026, corresponde ao depósito. Autores: Kirsten Sheehy, Jonathan Aguiñaga, Mary Janecka, Jessica Stephenson e Kate L. Laskowski.

Limite de acesso: a abertura direta do artigo retornou 403; os metadados e as seções de métodos e resultados foram recuperados pelo índice de busca da própria editora. O download direto do CSV também retornou 403. Conferi o CSV e o R Markdown originais dentro do ZIP local `doi_10_5061_dryad_jsxksn0r9__v20260506.zip`, em Downloads. A página do Dryad abriu normalmente.

## Conferência dos dados

Li `Dryad_molinésias_parasitos_tidy.xlsx`, abas `dados_tidy` e `documentacao`, e comparei as cinco variáveis originais, linha por linha, com `texas2022_parasite_20260421.csv` do ZIP. **Nenhuma diferença nos valores**, inclusive NA e contagens extremas. A origem tem 128 linhas × 5 colunas; a planilha tem **128 peixes × 8 colunas**. A unidade é um peixe dissecado. Os três acréscimos são ID de registro, grupo local–espécie e indicador de infecção; conferi as duas derivações.

| Variável categórica | Níveis e contagens |
|---|---|
| `local` | Brownsville: 38; Weslaco: 90 |
| `especie` | P. formosa: 69; P. latipinna: 59 |
| `sexo` | F: 108; M: 18; ausente: 2 |
| `grupo_local_especie` | Brownsville/formosa: 11; Brownsville/latipinna: 27; Weslaco/formosa: 58; Weslaco/latipinna: 32 |
| `infectado_01` | 0: 31; 1: 97 |

NA: `sexo`, 2; `comprimento_padrao_cm`, 10; **todas as demais colunas, zero**. O comprimento observado varia aproximadamente entre 1,747 e 4,827 cm. Há 128 IDs técnicos distintos, gerados pela ordem das linhas, sem garantia adicional de identificação biológica.

Contagem de parasitos: mínimo **0**, máximo **644**, **31 zeros (24,22%)**, média **42,6953**, variância amostral **7.999,2214** e variância/média **187,356**. Todos os oito indicadores numéricos do resumo e os vinte indicadores dos quatro grupos na documentação conferem. Esses números são cálculos desta avaliação, não estimativas retiradas do artigo.

## Análises

Executei no **R 4.6.1**, com **MASS 7.3-65**, preservando zeros e valores extremos. Nos modelos com comprimento, os dez NA deixam **118 peixes**; Poisson e binomial negativa usam exatamente essas mesmas linhas. A razão de dispersão abaixo é a soma dos resíduos de Pearson ao quadrado dividida pelos graus de liberdade residuais, diferente da razão descritiva variância/média.

| Análise executada | Resultado |
|---|---|
| Poisson: `parasitos_total_n ~ local + especie + comprimento_padrao_cm` | n=118; 114 gl residuais; dispersão **59,395**; AIC **4.983,967**. Forte sobredispersão. |
| Binomial negativa: mesma fórmula | Convergiu; θ=**0,4719**; dispersão Pearson **1,642**; AIC **864,693**. Melhora expressiva, mas ainda exige diagnóstico. |
| Poisson simples: `parasitos_total_n ~ grupo_local_especie` | n=128; dispersão **86,290**. Também inadequado para inferência sem tratar a sobredispersão. |
| Kruskal–Wallis entre os quatro grupos | n=128; H=**54,725**; 3 gl; p=**7,857 × 10⁻¹²**. Evidência de diferenças entre distribuições dos grupos. |

Na binomial negativa aditiva, os coeficientes são: Weslaco **−3,2796** (p<0,001), P. latipinna **−0,5739** (p=0,0534) e comprimento **1,0147** (p<0,001). Não interpretar essas associações como efeitos causais. O Kruskal–Wallis não separa os efeitos de local e espécie e não demonstra, sozinho, que todas as medianas diferem.

Nos 118 casos completos, a binomial negativa prevê **27,63 zeros**, frente a **29 observados**. A proporção de zeros, isoladamente, não comprova inflação de zeros em relação a esse modelo. Retirar o maior valor apenas numa análise de sensibilidade mudou pouco os coeficientes; isso não autoriza removê-lo da base.

O artigo e o R Markdown depositado separam presença/ausência (logística) e contagens positivas (binomial negativa). **O modelo didático acima inclui também os zeros**, logo responde sobre abundância por peixe e não reproduz a análise restrita aos infectados. Excluir zeros exige justificar a pergunta e considerar a distribuição truncada; não copiar automaticamente essa filtragem. O código depositado usa `glm` e `glm.nb`, sem termo aleatório nesses modelos de parasitos, embora o artigo os descreva como modelos mistos.

## Substitui o `quine`?

**Sim, para ensinar binomial negativa com vários preditores**, com equivalência parcial de estrutura. Ganha contexto de bioecologia de peixes, observações individuais, resposta inteira, fonte recente e CC0 confirmado. Tem dois fatores de dois níveis e uma covariável contínua, suficientes para uma regressão de contagens com vários preditores.

Perde a variedade de quatro fatores e de interações do original. Sexo oferece informação desigual entre espécies, e comprimento tem NA. A referência à “faixa etária” no pedido merece precisão: `Age` em `quine` representa categorias de etapa escolar, não idade numérica.

## Substitui o `InsectSprays`?

**Cobre Poisson, binomial negativa e Kruskal–Wallis, mas recomendo continuar procurando um substituto experimental.** Os quatro grupos atendem ao mínimo de oito animais por nível. Entretanto, são combinações de dois fatores observacionais, não quatro tratamentos independentes, e os tamanhos variam de 11 a 58.

Ao substituir o original integralmente, perderíamos o exemplo de experimento balanceado com seis tratamentos e a interpretação associada à atribuição experimental. Para essa finalidade, buscar estudo de pesca, aquicultura ou ciência animal com contagem por unidade independente, três a seis tratamentos, preferencialmente tamanhos iguais e pelo menos oito unidades por tratamento, e CC0 ou CC BY 4.0. Se o tratamento for aplicado ao tanque, a unidade experimental é o tanque; vários peixes do mesmo tanque não constituem réplicas independentes do tratamento.

## Riscos didáticos

- **Contagens extremas:** 644 e 390 são valores presentes na fonte. Preservá-los; não confundir agregação de parasitos com erro de digitação. Uma escala `log1p` pode ajudar a visualizar, sem mudar a resposta dos modelos de contagem.
- **Desequilíbrio e contexto espacial:** apenas 11 peixes no menor grupo. Há dois locais, sem replicação de locais por condição ambiental; não generalizar a diferença como efeito de um ambiente nem tratar os peixes como réplicas de um tratamento aplicado ao local.
- **Sexo e espécie:** todas as 69 P. formosa são fêmeas; P. latipinna tem 39 fêmeas, 18 machos e dois NA. Não é um cruzamento completo sexo × espécie. Comparar sexos dentro de P. latipinna ou espécies entre fêmeas responde a perguntas específicas, não a efeitos gerais independentes.
- **Ausências:** os modelos com comprimento perdem dez linhas, inclusive duas sem sexo. Informar o n efetivo e conferir se a exclusão altera a composição dos grupos. Não imputar sem uma justificativa.
- **Sem exposição para offset:** cada observação é um peixe, mas não há tempo de exposição, área ou esforço por animal. Modelar número de parasitos por peixe é possível sem offset. Comprimento é covariável, não offset automático; não chamar a resposta de taxa por tempo ou por área.
- **Colunas derivadas:** `grupo_local_especie` e `infectado_01` podem ser calculadas durante o preparo, para ensinar a transformação e evitar redundância. Não usar presença como preditor da própria contagem nem colocar grupo combinado e seus dois componentes juntos no mesmo modelo. Não usar o ID técnico como preditor.
- **Outros usos:** logística de presença/ausência, prevalência, tabelas de contingência, Mann–Whitney entre espécies dentro de um local e exploração comprimento–contagem. A logística aditiva convergiu com n=118. Brownsville/formosa não tem nenhum zero; análises logísticas desse local podem sofrer separação. No qui-quadrado, conferir frequências esperadas e considerar Fisher quando pequenas. Não comparar espécies agrupando os locais sem discutir o desequilíbrio.
- **Reprodução do artigo:** não juntar diretamente o arquivo comportamental, que tem ensaios repetidos por peixe. Não transportar os resultados publicados para o modelo com todos os peixes, pois as populações analisadas diferem.

## Recomendação final

**Aceitar somente para substituir `quine`, nesta rodada.** A base atende aos critérios numéricos, tem proveniência verificável, valores preservados e boa utilidade para regressão de contagens e prevalência. Pode apoiar Kruskal–Wallis adicionalmente. Manter a procura por um experimento balanceado para substituir `InsectSprays` preserva a diversidade didática do catálogo. A incorporação e a decisão sobre manter as colunas derivadas ficam para a curadoria seguinte.

| Conjunto substituído | Estrutura equivalente | O que se ganha | O que se perde | Veredito |
|---|---|---|---|---|
| `quine` | Em parte | Bioecologia de peixes, CC0, contagem individual e covariável contínua | Quatro fatores originais e maior variedade de combinações | Aceitar para binomial negativa com vários preditores |
| `InsectSprays` | Não, quanto ao delineamento | Contexto de peixes; cobertura dos três métodos solicitados | Experimento balanceado, seis tratamentos e interpretação experimental | Continuar buscando substituto experimental |
