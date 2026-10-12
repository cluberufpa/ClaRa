> Atualização após conciliação de registros (12/10/2026): o catálogo consolidado contém 62 conjuntos (53 internos, oito FSAdata, um MASS). D61 é anchova-do-norte; larvas de peixes passam a D62. Quantidades anteriores abaixo são históricas. Ver docs/CONCILIACAO_D61_D62_20261012.md.

# D44 e D48 — adaptação à ClaRa (12/10/2026)

Substituições autorizadas pelo professor e preparadas no checkout `ClaRa-dados`, branch `dados`. Os demais trabalhos já presentes no checkout foram preservados. Sem alteração de motores analíticos, dependências de execução ou versão nesta adaptação.

| Código | Objeto retirado | Objeto novo | Dimensão | Licença |
|---|---|---|---|---|
| D44 | plantas_absorcao_co2 (CO2) | percas_hipoxia | 449 × 4; 40 peixes | CC0 1.0 |
| D48 | laranjeiras_crescimento (Orange) | molinesias_crescimento | 1178 × 4; 34 peixes | CC BY 4.0 |

O catálogo continua com 61 registros. Fontes antigas, metadados e receitas históricas estão em `data-raw/substituidos/`. Os nomes antigos saíram do catálogo ativo. Não foram criados aliases com nomes de plantas para os dados de peixes.

## O que foi incorporado

- Fontes originais congeladas, com metadados oficiais e MD5 conferido.
- Preparo reproduzível em `data-raw/D44_percas_hipoxia/preparar.R` e `data-raw/D48_molinesias_crescimento/preparar.R`.
- Objetos RDA comprimidos em xz (3616 e 3436 bytes, respectivamente), colunas em português, identificadores e valores observados preservados.
- Registro no catálogo, documentação roxygen/Rd, exemplos de carregamento, fichas com de-para, atribuição, unidades e limites.
- Testes de integridade, cobertura, grupos, ocasiões ausentes e substituição no catálogo.

```r
percas <- clara::carregar_dados("percas_hipoxia")
molinesias <- clara::carregar_dados("molinesias_crescimento")
```

As molinésias entram com todas as medições. A ajuda ensina o recorte opcional para dez idades com cobertura completa (340 linhas, intervalos desiguais), sem criar outro conjunto no catálogo. Índice e previsões da fonte foram omitidos; os comprimentos são observados.

Nas percas, foram mantidas todas as 449 linhas e os 23 NA da resposta, incluindo as três linhas a 100% sem resposta. Os três grupos térmicos foram traduzidos como um único fator: não constituem um fatorial completo. A ordem de exposição ao oxigênio está associada ao tempo. Ambos os conjuntos exigem considerar a dependência dentro do peixe; nenhum verbo analítico foi atribuído indevidamente no catálogo.

## Validação

- Conferência direta do CSV e do XLSX: valores, ordem, identificadores e NA preservados.
- Reexecução dos dois preparos: catálogo idêntico, com 61 registros; os demais registros permanecem intactos nessa reexecução.
- Documentação gerada com roxygen2; `git diff --check` sem erros.
- `R CMD build --no-manual` e `R CMD check --no-manual --no-vignettes`: instalação, carregamento, documentação, dados e exemplos aprovados; **0 erros, 0 notas, 1 aviso**, já conhecido, de caracteres não ASCII no código preexistente.
- Pacote instalado: **709 verificações passaram, 0 falhas, 0 avisos nos testes; 8 testes externos pulados porque FSAdata não está instalado nesta sessão**. Os novos testes passaram.

O primeiro teste em desenvolvimento não encontrou automaticamente o helper no ambiente restrito; a suíte foi conferida com carregamento explícito do helper. O build também encontrou restrição de renomeação temporária. A validação final acima foi executada com R CMD diretamente, fora dessa restrição, sem alterar o código do pacote para contornar o ambiente. A tentativa intermediária via devtools exigia Rtools; o pacote puro R passou pelo comando direto sem compilação.

Logs, tarball, pacote instalado e script de conferência ficam fora do repositório em:

`C:/Users/evaldoms/.codex/visualizations/2026/10/12/01a13047-d388-7021-9eca-e7a31dd0827c/verificacao-clara-curvas/`

A conferência técnica não substitui a revisão didática do autor. Detalhes de fonte, adaptações e delineamento estão nas fichas de cada registro.
