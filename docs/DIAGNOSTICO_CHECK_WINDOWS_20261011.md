# Check no Windows — causa identificada e validação (11/10/2026)

Após o bloco 6, a instalação e o check completo da ClaRa 0.14.0 passaram
com o R já instalado em `C:/R/R-4.6.1`. Resultado: **0 erros, 0 notas e
1 aviso conhecido**, sobre acentos em textos do código. Os **668 testes**
passaram, sem falhas, avisos ou skips. Todos os exemplos do pacote passaram.

## Causa

O ambiente de execução dos comandos não continha a variável nativa do
Windows `PROCESSOR_ARCHITECTURE`. A arquitetura real foi conferida pelo
PowerShell (`RuntimeInformation.OSArchitecture`): **X64**, cujo valor nessa
variável é **AMD64**.

O `cli` 3.6.6 consulta essa variável ao encerrar seu temporizador. O
[código-fonte do cli](https://github.com/r-lib/cli/blob/main/src/thread.c)
obtém o valor com `getenv("PROCESSOR_ARCHITECTURE")` e o passa a `strcmp`
sem conferir se é nulo. Quando a variável está ausente, o encerramento
sofre violação de memória. O registro do Windows apontou `Rterm.exe`,
`ucrtbase.dll` e exceção `0xc0000005` (3221225477).

Isso explica por que o R chegava ao fim dos testes e gravava resultados,
mas encerrava com erro; na instalação, o processo de lazy loading também
era encerrado dessa forma. `rlang` e outras dependências reproduziam a
falha porque carregavam `cli`. A falha foi reproduzida sem a ClaRa.

## Isolamento e correção

| Execução isolada | Resultado |
|---|---|
| R base, digest ou Rcpp | Encerramento normal |
| cli, variável ausente | Código 3221225477 após imprimir CARGA/CLI_OK |
| rlang, variável ausente | Código 3221225477 após imprimir CARGA_OK |
| Desativar JIT, executar gc ou mudar a localidade | Não resolveu |
| Desativar temporizador com CLI_NO_THREAD | Não resolveu; a consulta à arquitetura ainda ocorre no encerramento |
| cli e rlang, PROCESSOR_ARCHITECTURE=AMD64 | Encerramento normal, código 0 |

A correção foi preparar o ambiente do processo e dos seus filhos:

```powershell
# Nesta máquina, a arquitetura nativa já foi confirmada como X64.
if (-not $env:PROCESSOR_ARCHITECTURE) {
  $env:PROCESSOR_ARCHITECTURE = 'AMD64'
}
$env:LC_ALL = 'English_United States.utf8'
```

Em outra máquina, conferir a arquitetura antes de preencher a variável;
preservar um valor já existente. Não definir AMD64 em Windows ARM64 por
suposição. A localidade UTF-8 válida também evita os avisos de inicialização
causados por `C.UTF-8` neste Windows, mas a causa da violação de memória
era a variável de arquitetura ausente.

Não foi necessário reinstalar R ou dependências, alterar o registro do
Windows, configurar variáveis globais, desativar byte compilation ou mudar
os dados e funções da ClaRa. O pacote usa o lazy loading normal.

## Validação completa

Com a variável restaurada, foram executados `R CMD build --no-manual` e
`R CMD check --no-manual` sobre o pacote com todos os 60 conjuntos.

- Build e check encerraram com código 0.
- Instalação passou, incluindo byte compilation e lazy loading.
- Carregamento em local temporário e definitivo passou.
- Carregar/descarregar pacote e namespace passou.
- Dependências, análise estática, documentação e exemplos passaram.
- Conteúdo de data/, caracteres e compressão dos dados passaram.
- Testes do pacote instalado: `FAIL 0 | WARN 0 | SKIP 0 | PASS 668`.
- Resultado final: `Status: 1 WARNING`, exclusivamente o aviso de
  caracteres não ASCII nos textos do código, aceito em CLAUDE.md.

Os produtos e logs estão fora dos repositórios, em:

```text
C:/Users/evaldoms/.codex/visualizations/2026/10/11/
01a12aaf-054f-7262-8f4c-90be0dea2d3e/verificacao-clara/
reparo_check/validacao/
  build.log
  check.log
  clara_0.14.0.tar.gz
  clara.Rcheck/00check.log
  clara.Rcheck/00install.out
  clara.Rcheck/tests/testthat.Rout
```

Os relatórios dos blocos registram a falha observada naquele momento;
este diagnóstico os atualiza quanto à validação técnica. Os conjuntos
provisórios continuam provisórios: check aprovado não conclui a curadoria
nem resolve autorizações de fonte. O balanço registra essas situações
separadamente. Sem mudança de versão, dependências, funções ou dados.
