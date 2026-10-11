# D08_pinguins_biometria — Pinguins: biometria do Arquipélago Palmer

- Código: D08. Objeto definitivo: `pinguins`. Origem EAPADados: `pinguins`.
- Dimensões: 344 × 8. Unidade: pinguim amostrado.
- Natureza: medição real, conforme origem; limites abaixo.
- Referência: Horst, Hill e Gorman (2020); Gorman, Williams e Fraser (2014); palmerpenguins, DOI 10.5281/zenodo.3960218.
- Licença: CC0 1.0. A licença MIT do código não relicencia os dados.
- Situação: provisório; migração autorizada pelo professor em 11/10/2026.

## Linhas, colunas e de-para

Todas as linhas, colunas, ordem e ausências preservadas. Nenhuma seleção nova,
imputação ou conversão de unidade. Classe normalizada para data.frame sem
remover fatores ou datas. Codificação Latin-1 como no D01.

Decisão anterior do balanço: sexo `femea` → `fêmea`; `macho` preservado na mesma ordem do fator.

Fontes congeladas em `fonte/`, com SHA256: objeto do EAPADados, documentação
roxygen e `palmerpenguins__penguins.rda`. O preparo verifica hashes e dimensões.
A documentação herdada preserva o histórico das adaptações já aplicadas.

## Uso didático

## Conferência da passada 1

Objeto conferido contra palmerpenguins 0.1.1 congelado antes da aplicação
da categoria já aprovada. Mesmas 344 linhas, oito colunas, ordem, medidas
e ausências. O xz ocupa 2.380 bytes; `data/` soma 45.100 bytes com catálogo.
Ajuda gerada; 264 expectativas passaram, zero falhas, erros, avisos ou skips.
Persistiu a falha preexistente no encerramento do processo R.

## Análises

Estatística descritiva; Teste t; ANOVA de um fator; ANCOVA; PCA. Verbo: comparar_medias.

## Pendências para a curadoria

Preservar ausências de sexo e biometria; selecionar casos completos somente na análise. Aplicar aprovação anterior de sexo fêmea/macho, conservando a ordem do fator.

Instalação e check completo serão conferidos ao fim do bloco. Falhas do
ambiente R não serão contornadas com mudanças nas funções da ClaRa.

## Fonte original congelada

palmerpenguins 0.1.1, objeto penguins, ajuda e DESCRIPTION preservados. A tradução herdada confere com os valores originais. Referência de 2020 cita a versão 0.1.0; o objeto congelado desta conferência vem da 0.1.1. Licença CC0 confirmada na documentação oficial.
