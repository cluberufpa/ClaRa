# D02_barbo_morfometria — Barbo: morfometria corrigida

- Código: D02. Objeto definitivo: `morfometria_barbo`. Origem EAPADados: `morfometria_barbo`.
- Dimensões: 100 × 13. Unidade: peixe; medidas previamente corrigidas pelo comprimento padrão.
- Natureza: medição real, conforme origem; limites abaixo.
- Referência: Bánó e Takács (2022); Mendeley Data, DOI 10.17632/c8856zg4hj.1.
- Licença: CC BY 4.0. A licença MIT do código não relicencia os dados.
- Situação: provisório; migração autorizada pelo professor em 11/10/2026.

## Linhas, colunas e de-para

Todas as linhas, colunas, ordem e ausências preservadas. Nenhuma seleção nova,
imputação ou conversão de unidade. Classe normalizada para data.frame sem
remover fatores ou datas. Codificação Latin-1 como no D01.

De-para: identidade; nenhuma mudança nova de nomes ou categorias.

Fontes congeladas em `fonte/`, com SHA256: objeto do EAPADados, documentação
roxygen e `morfometria_barbo.csv`. O preparo verifica hashes e dimensões.
A documentação herdada preserva o histórico das adaptações já aplicadas.

## Uso didático

## Conferência da passada 1

O CSV curado de origem confere com o objeto anterior: 100 linhas, 13 colunas,
mesma ordem, categorias e medidas (tolerância numérica 1e-12). Não houve
recálculo da correção alométrica. O arquivo xz ocupa 7.536 bytes. Com D01,
D02 e catálogo, `data/` soma 8.804 bytes. A ajuda foi gerada e a suíte
completa passou nas 217 expectativas; a falha preexistente de encerramento
do processo R persistiu após salvar os resultados dos testes.

## Análises

Regressão linear simples; PCA; Agrupamento hierárquico. Verbo: relacionar_variaveis.

## Pendências para a curadoria

Validar a correção alométrica na fonte completa; rio e populacao são rótulos colineares. Medidas de forma não representam crescimento individual.

Instalação e check completo serão conferidos ao fim do bloco. Falhas do
ambiente R não serão contornadas com mudanças nas funções da ClaRa.
