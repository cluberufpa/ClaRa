# D41 — Mesocosmos: crescimento de peixes e secagem prévia

- Registro: `D41_mesocosmos_secagem`; objeto definitivo: `mesocosmos_secagem`; nome_eapadados: ``.
- Dimensões: 30 × 12; unidade: peixe por tanque experimental com medidas inicial e final disponíveis na fonte.
- Natureza: real; origem: Dryad::mesocosmos_secagem.
- Referência: Ward (2023), An analysis of the effects of prior drying and vertebrate colonization on ecological functioning and vertebrate fitness, Dryad v3, DOI 10.5061/dryad.hx3ffbgkn, Fish_Data_Dryad.xlsx.
- Licença: CC0-1.0. A licença MIT do código não altera a da fonte.
- Situação: provisório.

## Linhas e de-para

Todas as linhas e sua ordem preservadas. Ausências mantidas; nenhuma imputação.
Fish Growth, de Fish_Data_Dryad.xlsx → tabela principal. Tank/A_Pres/Drying/Treatment/Initial_Date/Initial_SL/Initial_Biomass/Final_Date/Final_SL/Final_Biomass/Abs_SLGrowth/Rel_SLGrowth → id_tanque, presenca_anfibios, secagem, tratamento, data_inicial, comprimento_padrao_inicial_cm, biomassa_inicial_estimada_g, data_final, comprimento_padrao_final_cm, biomassa_final_estimada_g, crescimento_absoluto_cm, crescimento_relativo. Y/N → sim/não; DR/ND → seco e reabastecido/não seco; datas sem horário. Todas as 30 linhas e medidas originais preservadas; nenhuma exclusão nova. Outros cinco conjuntos e scripts preservados na fonte, sem juntá-los por unidades incompatíveis.

As fontes usadas no preparo estão preservadas integralmente em `fonte/`, com SHA256. Tabela selecionada diretamente da fonte primária. Demais tabelas preservadas integralmente, sem criar conjuntos adicionais nesta passada.

## Uso didático

Planejamento fatorial; Crescimento relativo; ANOVA de dois fatores candidata. Principal: Planejamento fatorial. Exemplo da ajuda resume os dados; não promete que a ClaRa tenha motor para todas as análises listadas.

## Pendências para a curadoria

Selecionada a tabela de crescimento de peixes para o fatorial presença de anfíbios × secagem; todas as seis tabelas e scripts originais ficam preservados. A fonte contém 30 peixes de 32 introduzidos; confirmar razão das duas ausências, sem adicionar/remover linhas. Biomassas calculadas de regressão comprimento-peso, não pesagens diretas. Crescimento relativo é razão sem dimensão, embora README atribua cm. Datas finais variam: revisar duração antes da comparação. Dois pontos por peixe não sustentam curva de Gompertz.
