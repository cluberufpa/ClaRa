# D04_doubs_ambiente — Doubs: ambiente e riqueza de peixes

- Código: D04. Objeto definitivo: `doubs_ambiente`. Origem EAPADados: `doubs_ambiente`.
- Dimensões: 30 × 13. Unidade: estação do rio Doubs.
- Natureza: medição real, conforme origem; limites abaixo.
- Referência: Verneaux (1973); ade4::doubs; Borcard, Gillet e Legendre (2018), Numerical Ecology with R.
- Licença: GPL-2 | GPL-3 conforme documentação herdada; não relicenciado como MIT. A licença MIT do código não relicencia os dados.
- Situação: provisório; migração autorizada pelo professor em 11/10/2026.

## Linhas, colunas e de-para

Todas as linhas, colunas, ordem e ausências preservadas. Nenhuma seleção nova,
imputação ou conversão de unidade. Classe normalizada para data.frame sem
remover fatores ou datas. Codificação Latin-1 como no D01.

De-para: identidade; nenhuma mudança nova de nomes ou categorias.

Fontes congeladas em `fonte/`, com SHA256: objeto do EAPADados, documentação
roxygen e `doubs_ambiente.R`. O preparo verifica hashes e dimensões.
A documentação herdada preserva o histórico das adaptações já aplicadas.

## Uso didático

## Conferência da passada 1

Fonte original congelada e conferida: 30 estações, 11 variáveis ambientais
idênticas ao ade4 e riqueza recalculada somente para conferência. O xz
ocupa 1.112 bytes; `data/` soma 13.696 bytes com catálogo. Ajuda gerada;
233 expectativas passaram, zero falhas, erros, avisos ou skips. A violação
de acesso preexistente ocorreu no encerramento do processo R.

## Análises

PCA; Agrupamento hierárquico. Verbo: aguarda verbo da ClaRa para a análise principal; exemplo usa summary().

## Pendências para a curadoria

Conferir escalas: pH está multiplicado por 10; não interpretar as demais colunas em unidades físicas antes de conferir seus fatores de escala. Preservar estações E01-E30 nos rownames nesta passada; propor coluna de identificação na passada 2. Preservar licença da origem.

Instalação e check completo serão conferidos ao fim do bloco. Falhas do
ambiente R não serão contornadas com mudanças nas funções da ClaRa.

## Fonte original e escalas conferidas

Fonte congelada: ade4 1.7-24, objeto doubs (RDS e ajuda), GPL (>= 2). Textos GPL-2 e GPL-3 preservados. As 11 variáveis ambientais e a riqueza conferem com essa fonte. As unidades incorretas da ajuda herdada foram corrigidas conforme o manual do ade4, sem conversão dos valores: dfs km × 10; flo m³/s × 100; pH × 10; pho/nit/amm mg/L × 100; oxy/bdo mg/L × 10; slo = ln(declividade em por mil × 100 + 1). har é mg/L de cálcio. Altitude permanece em m.

## Decisão do professor — 11/10/2026

Manter e usar a fonte Doubs na ClaRa. O professor definirá posteriormente o encaminhamento de licenciamento. A licença GPL (>= 2) da fonte permanece registrada; não houve relicenciamento como MIT nem aprovação de nova licença.
