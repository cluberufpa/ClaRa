# D23 — Caranguejos Leptograpsus: morfometria

- Registro: `D23_caranguejos_morfometria`; objeto definitivo: `crabs_morfometria`; nome_eapadados: `crabs_morfometria`.
- Dimensões: 200 × 10; unidade: caranguejo individual.
- Natureza: real; origem: EAPADados::crabs_morfometria.
- Referência: MASS::crabs; Campbell e Mahon (1974); Venables e Ripley (2002).
- Licença: GPL-2 | GPL-3, MASS. A licença MIT do código não altera a da fonte.
- Situação: provisório.

## Linhas e de-para

Todas as linhas e sua ordem preservadas. Ausências mantidas; nenhuma imputação.
Somente id_caranguejo convertido em texto pela convenção de identificadores. Não aplicadas propostas pendentes de mudar os quartis.

As fontes usadas no preparo estão preservadas integralmente em `fonte/`, com SHA256. A conferência compara o objeto herdado com a planilha/CSV que o originou, antes das adaptações autorizadas. Uma fonte local organizada não equivale a reextração independente de toda a publicação.

## Uso didático

Amostragem estratificada; ANCOVA; PCA. Principal: Amostragem estratificada. Exemplo da ajuda resume os dados; não promete que a ClaRa tenha motor para todas as análises listadas.

## Pendências para a curadoria

Classes de quartis mantidas, fora de PCA; renomeação fina pendente. Sexo e estratos preservados. Não confundir caranguejos Leptograpsus com a outra base de caranguejos. ANCOVA exige verificar interação, forma funcional e diagnósticos, sem prometer adequação automática.

## Leitura na hora (12/10/2026)

Fornecedor: `MASS::crabs`, versão validada 7.3-65; licença GPL-2 | GPL-3. Autoria do pacote: Brian Ripley e Bill Venables. Use `carregar_dados("crabs_morfometria")`; `data()` e `clara::crabs_morfometria` deixam de fornecer este conjunto. Receita e de-para em `R/dados_pacotes.R`. Comparação com a cópia anterior: `all.equal()` TRUE, com linhas, colunas, tipos e níveis preservados. As cópias binárias deixam de ser mantidas. Os registros anteriores desta ficha descrevem a migração histórica.
