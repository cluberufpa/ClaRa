# Proposta — D002_artemia_racao (não incorporado)

Data: 11/10/2026. Origem: EAPADados::artemia. Objeto proposto:
`artemia_racao`; código D002 proposto, ainda não atribuído no catálogo.

A documentação da origem declara dados fictícios. Proposta: migrar como
**sintético de treino**, nunca como dados reais. O professor foi consultado
no chat; a decisão continua pendente. Nenhum objeto novo foi criado em
`data/`, nenhuma análise foi aprovada e nenhuma linha foi incluída no catálogo.

Objeto anterior: 14 × 2, grupos A e B com sete valores cada, sem NA.
Preservar `racao` (fator nominal A, B) e `taxa_crescimento_mg_dia`
(double, mg/dia), nomes exigidos pela Trilha. As categorias são descritas
na documentação como farelo de arroz e farelo de babaçu. Preservar os
códigos A/B, a ordem e todos os valores. Nenhuma exclusão, imputação,
conversão ou coluna derivada é proposta.

A aba src_artemia da fonte completa foi copiada sem alteração para a
planilha de revisão. Os originais e o objeto anterior estão em `fonte/`,
com SHA256. Cabeçalhos da cópia de revisão continuam os da fonte.

A unidade experimental e o protocolo de coleta não estão documentados;
não inferir que cada linha corresponde a animal ou recipiente independente.
Usos de treino: teste t de duas amostras, Mann-Whitney, descritiva e boxplot.
A natureza fictícia impede apresentar conclusões como evidência de um
experimento real. Fonte bibliográfica e licença específica não localizadas.

Abra `artemia_para_revisao.xlsx`, aba Revisão do autor, para registrar a
aprovação e eventuais ajustes. O preparo só será aplicado após decisão.
