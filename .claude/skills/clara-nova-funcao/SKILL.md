---
name: clara-nova-funcao
description: Use ao criar ou revisar uma função da ClaRa (o dialeto amigável de R do projeto), para seguir o padrão da receita com mostrar_codigo, o estilo tidyverse sem %in% e os comentários em português.
---

# Criar uma função nova da ClaRa

Leia o CLAUDE.md da raiz antes de começar. Ele traz as regras de estilo.
Use `comparar_medias()` em `R/clara.R` como modelo vivo.

## Passo a passo

1. **Comece pela pergunta da pesquisa.** O nome da função é um verbo em
   português que responde a ela (`relacionar_variaveis`, `comparar_proporcoes`).
   Escreva no cabeçalho: Pergunta, o que a função faz, o que devolve, Exemplo.

2. **Escreva primeiro a receita, como R comum que um aluno digitaria.**
   Pipe `|>`, verbos do dplyr, `case_when()`, `tidy()` depois de testes
   clássicos. Nada de `%in%` ou outros `%...%`. Numere os passos em
   comentários (`# 1. ...`). Teste a receita sozinha, com nomes reais, antes
   de transformá-la em função.

3. **Troque os nomes concretos por marcadores** `<<DADOS>>`, `<<RESPOSTA>>`,
   `<<GRUPOS>>`, `<<CONFIANCA>>` etc. Aspas dentro da receita vão escapadas
   (`\"`).

4. **Monte a função no padrão:**

   ```r
   nova_funcao <- function(dados,
                           resposta,
                           grupos,
                           confianca      = 0.95,
                           mostrar_codigo = FALSE) {

     # Guardamos o nome da tabela que o aluno usou.
     nome_dados <- nome_do_objeto(substitute(dados), padrao = "dados")

     # Guardamos os nomes das colunas, como o aluno as escreveu.
     coluna_resposta <- rlang::as_name(rlang::ensym(resposta))
     coluna_grupos   <- rlang::as_name(rlang::ensym(grupos))

     # Antes de calcular, conferimos se as colunas servem para a análise.
     conferir_colunas(dados, coluna_resposta, coluna_grupos)

     # A receita, com marcadores <<...>>.
     receita <- "..."

     # Trocamos os marcadores pelos nomes desta análise.
     receita <- preencher_receita(receita, list(DADOS = nome_dados, ...))

     # Rodamos a receita, mostrando o código antes, se o aluno pediu.
     resultado <- executar_receita(
       receita        = receita,
       objetos        = rlang::set_names(list(dados), nome_dados),
       pacotes        = c("dplyr", "broom"),
       mostrar_codigo = mostrar_codigo
     )

     # Anotamos o que foi analisado e damos uma etiqueta ao resultado.
     resultado$nomes <- list(dados = nome_dados, ...)
     structure(resultado, class = "clara_nome_da_analise")
   }
   ```

   Funções que agem sobre um resultado recebem `resultado` como primeiro
   argumento e usam `<<RESULTADO>>$parte` na receita.

5. **Se a função devolve uma lista**, crie o método `print.clara_...` na seção
   "Exibição no console": título, n, tabelas principais, uma frase com a
   conclusão (vírgula decimal via `numero()` e `escrever_p()`) e a lista das
   partes abertas com `$`.

6. **Conferências amigáveis**: problemas de entrada viram `stop()` com
   mensagem em português que diz o que fazer, decididos por `case_when()`
   (veja `conferir_colunas()`).

7. **Comentários**: uma frase acima de cada linha nas funções do aluno; sem
   travessões; linguagem humanizada. Peças reaproveitáveis vão para a seção
   "Motor das receitas".

8. **Teste antes de entregar** com `Rscript`:
   - o exemplo roda do início ao fim;
   - `mostrar_codigo = TRUE` imprime uma receita que, copiada e colada numa
     sessão limpa (com os pacotes carregados), dá o mesmo resultado;
   - funciona com e sem aspas nos nomes das colunas e com o pipe;
   - as mensagens de erro aparecem para coluna inexistente e nome com símbolo;
   - gráficos: salve um PNG e olhe.

9. **Atualize o CLAUDE.md** (seção "Como o aluno usa" e "Decisões em aberto")
   e o exemplo da análise em `exemplos/<nome_da_analise>.R` (um roteiro por
   análise, rodando a partir da raiz, que grava suas figuras em `exemplos/`).
