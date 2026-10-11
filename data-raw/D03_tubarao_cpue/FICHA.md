# D03_tubarao_cpue — Tubarão: CPUE por embarcação e data

- Código: D03. Objeto definitivo: `cpue_tubarao`. Origem EAPADados: `cpue_tubarao`.
- Dimensões: 424 × 5. Unidade: registro de embarcação e data; desenho a confirmar.
- Natureza: medição real, conforme origem; limites abaixo.
- Referência: Dados próprios de monitoramento pesqueiro de 1995 a 2007, publicados em outro formato conforme declaração do professor em 11/10/2026; referência bibliográfica a completar.
- Licença: Uso na ClaRa autorizado pelo professor; licença específica a definir. A licença MIT do código não relicencia os dados.
- Situação: provisório; migração autorizada pelo professor em 11/10/2026.

## Linhas, colunas e de-para

Todas as linhas, colunas, ordem e ausências preservadas. Nenhuma seleção nova,
imputação ou conversão de unidade. Classe normalizada para data.frame sem
remover fatores ou datas. Codificação Latin-1 como no D01.

De-para: identidade; nenhuma mudança nova de nomes ou categorias.

Fontes congeladas em `fonte/`, com SHA256: objeto do EAPADados, documentação
roxygen e `dados_brutos_eapadados.xlsx`. O preparo verifica hashes e dimensões.
A documentação herdada preserva o histórico das adaptações já aplicadas.

## Uso didático

## Conferência da passada 1

Conferido com a aba original `cpue_tubarao` do workbook preservado: 424 × 5,
mesma ordem, embarcação, ano, mês, CPUE e datas. A data mantém classe Date;
nenhum recorte de CPUE foi aplicado. O xz ocupa 3.376 bytes; `data/` soma
12.368 bytes com três conjuntos e catálogo. Documentação gerada; 226
expectativas passaram, zero falhas, erros, avisos ou skips. Persistiu a
violação de acesso preexistente no encerramento do processo R.

## Análises

Séries temporais; Kruskal-Wallis e Dunn; Estatística descritiva. Verbo: aguarda verbo da ClaRa para a análise principal; exemplo usa summary().

## Pendências para a curadoria

Procedência própria confirmada pelo professor em 11/10/2026, com publicação em outro formato. Completar referência bibliográfica, créditos, licença específica, unidade da CPUE e independência. Manter Vessel, Year, Month, CPUE e Data nesta passada; tradução fica para a passada 2.

Instalação e check completo serão conferidos ao fim do bloco. Falhas do
ambiente R não serão contornadas com mudanças nas funções da ClaRa.
