# D06_salvelino_formalina — Salvelino: formalina e remoção de ovos mortos

- Código: D06. Objeto definitivo: `salvelino_formalina_remocao`. Origem EAPADados: `salvelino_formalina_remocao`.
- Dimensões: 30 × 7. Unidade: unidade experimental do incubatório, não um ovo individual.
- Natureza: medição real, conforme origem; limites abaixo.
- Referência: Olk, Lydersen e Wollebæk (2023); DataverseNO, DOI 10.23642/USN.7334573.
- Licença: CC BY 4.0. A licença MIT do código não relicencia os dados.
- Situação: provisório; migração autorizada pelo professor em 11/10/2026.

## Linhas, colunas e de-para

Todas as linhas, colunas, ordem e ausências preservadas. Nenhuma seleção nova,
imputação ou conversão de unidade. Classe normalizada para data.frame sem
remover fatores ou datas. Codificação Latin-1 como no D01.

De-para: identidade; nenhuma mudança nova de nomes ou categorias.

Fontes congeladas em `fonte/`, com SHA256: objeto do EAPADados, documentação
roxygen e `salvelino_formalina_remocao.csv`. O preparo verifica hashes e dimensões.
A documentação herdada preserva o histórico das adaptações já aplicadas.

## Uso didático

## Conferência da passada 1

CSV curado conferido com o objeto anterior: 30 × 7, mesmas unidades,
tratamentos, contagens, percentuais e ordem. O xz ocupa 696 bytes;
`data/` soma 40.832 bytes com catálogo. Ajuda gerada; 248 expectativas
passaram, zero falhas, erros, avisos ou skips. Persistiu a falha
preexistente no encerramento do processo R.

## Análises

ANOVA de dois fatores com interação; Estatística descritiva. Verbo: aguarda verbo da ClaRa para a análise principal; exemplo usa summary().

## Pendências para a curadoria

Delineamento desequilibrado, com 12, 8, 3 e 7 unidades. Conferir pressupostos e a transformação do artigo. Aguarda verbo da ClaRa para ANOVA de dois fatores.

Instalação e check completo serão conferidos ao fim do bloco. Falhas do
ambiente R não serão contornadas com mudanças nas funções da ClaRa.
