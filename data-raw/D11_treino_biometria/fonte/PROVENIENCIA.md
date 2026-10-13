# Fonte

`Treino-Transformacoes.xlsx` é a planilha de treino da Trilha (antes CatalyseR),
copiada sem alteração de `TRILHA/inst/app/dados/` em 13/10/2026. Dados fictícios,
feitos de propósito com defeitos, para exercitar o preparo de dados. A Trilha
continua lendo a sua própria cópia na tela de importação e nos testes.

Abas:

| Aba | Uso |
|---|---|
| `biometria` | 71 linhas × 10 colunas; vira `treino_biometria` (D11) |
| `desembarques_largo` | 4 portos × 3 anos de captura em formato largo; **não entra na ClaRa**: o exercício de empilhar já é o do D37 `treino_desembarque`, mais completo (ano e variável no nome da coluna) |
| `guia` | qual coluna exercita cada recurso; transcrito na ajuda de `treino_biometria` |

Os defeitos da aba `biometria` são intencionais e ficam todos no conjunto:

- **Texto inconsistente:** `especie`, `local` e `sexo` misturam caixa (`corvina`,
  `Corvina`, `CORVINA`), espaços nas pontas (` Braganca `) e duplos
  (`Pescada  Amarela`), e codificações diferentes (`f`, `F`, `Femea`). A leitura
  usa `trim_ws = FALSE` para não apagar os espaços.
- **Valores ausentes:** 5 em `comprimento_cm` e 6 em `peso_g`.
- **Duplicatas:** as três últimas linhas repetem por inteiro as de `id` 4, 18 e 41.
- **Coluna composta:** `amostra` junta local e estação (`Caratateua_Seca`).
- **Data como texto:** `data_coleta` está em `dd/mm/aaaa`.
- **Escalas diferentes:** `peso_g` em gramas (para reescalar a kg), `cpue` e
  `profundidade_m` em escalas distintas (para padronizar).
