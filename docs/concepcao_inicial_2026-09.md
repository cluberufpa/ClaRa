---
title: "Projeto ClaRa: Registro e Especificação da Linguagem"
subtitle: "Memória da Conversa e Fundamentos Conceituais"
date: "2026-09-14"
format:
  pdf:
    toc: true
    number-sections: true
    geometry:
      - top=25mm
      - bottom=25mm
      - left=25mm
      - right=25mm
---

# Contexto e Motivação Inicial

## A Proposta
Desenvolvimento de uma camada de programação de alto nível, voltada ao ser humano, que opere sobre o ecossistema da linguagem R (com suporte direto no RStudio, Positron e VS Code), agregando facilidades sintáticas do Python e a expressividade matemática de Julia. O foco central não é a criação de um compilador isolado, mas sim uma DSL (*Domain-Specific Language*) ergonômica voltada prioritariamente ao **ensino, à aprendizagem e à análise estatística**.

---

# Diálogo e Tomadas de Decisão Conceituais

## 1. Ergonomia e Estilo Inicial
* **Abordagem semântica:** Código estruturado como frases declarativas em prosa, reduzindo ruído visual e parâmetros crípticos (ex.: substituição de `na.rm = TRUE` por termos como `sem = nulos`).
* **Definição de funções:** Criação de rotinas com cláusulas declarativas de premissa (`exigir:`), eliminando burocracia de validações manuais aninhadas.
* **Influência multiplataforma:**
  * **R Moderno:** Fluxo com pipes (`|>`), dados tabulares e motor de testes estatísticos.
  * **Python:** Clareza estrutural, blocos legíveis e argumentos descritivos.
  * **Julia:** Expressividade matemática natural, intervalos e facilidade algébrica.

## 2. Decisão de Idioma: Totalmente em Português
Ficou estabelecido que a língua-base e a semântica da linguagem serão **exclusivamente em português**.
* **Fundamento:** Eliminar atrito cognitivo para estudantes e pesquisadores lusófonos.
* **Tradutibilidade garantida:** A estrutura semântica apoia-se em uma Árvore Sintática Abstrata (AST) consistente com mapeamento 1:1, permitindo transpilação automática posterior para R nativo, Python ou inglês.

## 3. A Escolha do Nome: ClaRa
Dentre as opções avaliadas (*Fluente*, *Dialeto*, *Vernácula*, *FluenteR*, *ClaRamente*), a denominação escolhida foi **ClaRa**:
* Lembra a simplicidade e o acolhimento de nomes como *Julia*.
* Carrega o significado literal de transparência e clareza de código.
* Destaca o **R** maiúsculo no meio, registrando sua base computacional.
* Extensão de arquivos definida: `.clara`.

---

# Síntese das Influências Paradigmáticas

## A Herança da Julia (Matemática no Ensino)
* **Multiplicação justaposta:** Escrita de coeficientes colados (`2pi * r`, `2x + 3y`).
* **Intervalos reais:** Sintaxe como `p_valor em [0.01, 0.05]` ou `0.01 <= p_valor <= 0.05`.
* **Vetorização límpida:** Sem necessidade de recorrer precocemente a laços complexos ou *comprehensions* densas.

## A Herança do Python (Escrita Limpa)
* **Delimitação simples:** Uso de dois-pontos (`:`) e encerramento explícito (`fim`).
* **Argumentos claros:** Uso de preposições semânticas (`de`, `por`, `onde`, `com`).

## A Base no R (Estatística e Hipóteses Didáticas)
* Substituição de nomes de testes baseados em autores ou acrônimos opacos por nomes que ensinam a metodologia:
  * `testar_normalidade()` no lugar de `shapiro.test()`.
  * `testar_diferenca()` no lugar de `t.test()`.
  * `testar_medianas()` no lugar de `wilcox.test()`.
  * `ajustar_modelo_linear()` no lugar de `lm()`.

---

# Especificação do Script Demonstrativo (`.clara`)

```clara
usar: ClaRa

# Definição de Rotina Matemática
rotina calcular_fator_condicao(peso, comprimento, expoente_alometrico = 3.0):
  exigir: peso > 0
  exigir: comprimento > 0
  
  fator_k = 100 * (peso / comprimento^expoente_alometrico)
  retornar fator_k
fim

# Pipeline Analítico
dados_processados = dados_brutos |>
  filtrar(onde = peso > 0 & comprimento > 0) |>
  adicionar(k = calcular_fator_condicao(peso, comprimento)) |>
  agrupar(por = estacao_coleta) |>
  resumir(
    media_k = media(de = k, sem = nulos),
    total_amostras = contar()
  )

# Teste Estatístico Didático
teste = dados_brutos |>
  testar_diferenca(
    variavel = peso,
    entre_grupos = regiao,
    supondo_variancias_iguais = falso,
    confianca = 95%
  )

se teste$p_valor < 0.05 entao:
  mostrar("Rejeita-se H0: Evidência de diferença estatística.")
senao:
  mostrar("Não se rejeita H0: Diferença não demonstrada.")
fim
```

---

# Dicionário de Mapeamento Básico

| Termo em ClaRa (PT) | Termo em Inglês | Equivalente no R |
| :--- | :--- | :--- |
| `rotina ... fim` | `routine ... end` | `function(...) { ... }` |
| `exigir:` | `ensure:` / `require:` | `stopifnot(...)` |
| `retornar` | `return` | `return(...)` |
| `filtrar(onde = ...)` | `filter(where = ...)` | `dplyr::filter(...)` |
| `adicionar(...)` | `mutate(...)` | `dplyr::mutate(...)` |
| `agrupar(por = ...)` | `group(by = ...)` | `dplyr::group_by(...)` |
| `resumir(...)` | `summarise(...)` | `dplyr::summarise(...)` |
| `sem = nulos` | `ignoring = nulls` | `na.rm = TRUE` |
| `testar_normalidade()` | `test_normality()` | `shapiro.test()` |
| `testar_diferenca()` | `test_difference()` | `t.test()` |

---

# Fases do Projeto e Uso Futuro com Agentes

1. **Fase 1 (Pacote R):** Biblioteca inicial com funções envelopadoras e gramática amigável.
2. **Fase 2 (Parser/Transpilador):** Interpretador de scripts `.clara` para execução no ambiente R.
3. **Fase 3 (Agentes de IA):** Especificação formal (EBNF/Lark) para geração de código, testes automáticos e tradução bidirecional.