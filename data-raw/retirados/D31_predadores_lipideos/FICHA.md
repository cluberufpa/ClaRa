# D31 — Predadores: assinaturas de ácidos graxos

- Registro: `D31_predadores_lipideos`; objeto definitivo: `qfasa_predadores`; nome_eapadados: `qfasa_predadores`.
- Dimensões: 10 × 70; unidade: assinatura lipídica de biópsia; 10 amostras de apenas 4 animais.
- Natureza: real; origem: EAPADados::qfasa_predadores.
- Referência: Stewart e colaboradores, QFASA 1.2.1, objeto predatorFAs; CRAN.
- Licença: MIT + file LICENSE, QFASA 1.2.1. A licença MIT do código não altera a da fonte.
- Situação: provisório.

## Linhas e de-para

Todas as linhas e sua ordem preservadas. Ausências mantidas; nenhuma imputação.
Decisão anterior aprovada: SampleCode/AnimalCode/SampleGroup/Biopsy → id_amostra/id_animal/grupo_amostra/biopsia. Os 66 códigos de ácidos e todos os valores são preservados, sem normalização ou corte.

As fontes usadas no preparo estão preservadas integralmente em `fonte/`, com SHA256. A conferência compara o objeto herdado com a planilha/CSV que o originou, antes das adaptações autorizadas. Uma fonte local organizada não equivale a reextração independente de toda a publicação.

## Uso didático

PCA; HCA; Assinaturas lipídicas. Principal: PCA. Exemplo da ajuda resume os dados; não promete que a ClaRa tenha motor para todas as análises listadas.

## Pendências para a curadoria

São quatro animais com biópsias repetidas, não dez réplicas independentes. Grupos T/T1/T2 não têm significado explicado na ajuda primária. Preservados os códigos de ácidos: c7Mec16.0 difere de c7Me16.0 nas presas. Não unir painéis nem aplicar QFASA sem conferir a lista FA e os coeficientes. Dados composicionais; PCA/HCA exploratórias exigem seleção justificada e tratamento de escala.
