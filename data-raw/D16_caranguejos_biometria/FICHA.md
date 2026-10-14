# D16 — Caranguejos de Bragança: biometria por local, sexo e estação

- Registro: `D16_caranguejos_biometria`; objeto definitivo: `caranguejos_biometria`; nome_eapadados: `biometria_caranguejos`.
- Dimensões: 993 × 5; unidade: registro de indivíduo; identificação da coleta a confirmar.
- Natureza: real; origem: EAPADados::biometria_caranguejos.
- Referência: Estudo de campo em Bragança, PA; referência bibliográfica a completar.
- Licença: Não localizada; créditos e autorização a completar. A licença MIT do código não altera a da fonte.
- Situação: provisório; autorização e licença da fonte pendentes.

## Linhas e de-para

Todas as linhas e sua ordem preservadas. Ausências mantidas; nenhuma imputação.
Decisão anterior aprovada: Local/Sexo/Estacao/LC/CC → local/sexo/estacao/largura_carapaca/comprimento_carapaca; Fêmea/Macho → fêmea/macho; Chuvosa/Seca → chuvosa/seca. Unidade pendente, sem sufixo inventado.

As fontes usadas no preparo estão preservadas integralmente em `fonte/`, com SHA256. A conferência compara o objeto herdado com a planilha/CSV que o originou, antes das adaptações autorizadas. Uma fonte local organizada não equivale a reextração independente de toda a publicação.

## Uso didático

Teste t; ANOVA de dois fatores; Estatística descritiva; Regressão linear. Principal: ANOVA de dois fatores. Exemplo da ajuda resume os dados; não promete que a ClaRa tenha motor para todas as análises listadas.

## Pendências para a curadoria

Unidades das medidas, autoria, licença e protocolo a confirmar. A ajuda herdada declara mm, mas a decisão de curadoria mantém unidade pendente, portanto nomes sem sufixo de unidade. Preservar as 551 linhas repetidas; não excluir registros sem identificação da coleta. Nome definitivo sugerido: caranguejos_biometria.

## Usos secundários (13/10/2026)

ANCOVA: `lm(comprimento_carapaca ~ largura_carapaca * sexo)` (ou `* local`) testa se machos e fêmeas têm a mesma relação entre as medidas da carapaça. Cada linha é um caranguejo.
