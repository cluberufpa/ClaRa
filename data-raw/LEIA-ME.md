# Dados da ClaRa — acompanhamento da migração

## Como revisar o primeiro conjunto

Abra `isoproteica_bagre/bagres_para_revisao.xlsx`. A aba **Dados para revisar**
reproduz somente a aba `src_isoproteica` da fonte, sem mudar nomes, valores ou
ordem. A aba **Revisão do autor** reúne o contexto e os campos azuis para suas
observações. Salve a planilha e avise no chat para que as decisões sejam lidas.
Ela é uma cópia de consulta; a fonte preservada em `fonte/` não deve ser editada.

O professor aprovou os bagres no chat em 11/10/2026 e solicitou o preparo
enquanto aguarda a resposta dos autores. O nome final é
`D001_bagre_racao_isoproteica`, com `racao` e `peso_medio_final_g`. As fontes e a
planilha de revisão continuam preservadas; a autorização da fonte permanece
pendente na ficha, na ajuda e no catálogo.

| Conjunto atual | Situação | Data | Registro definitivo |
|---|---|---|---|
| isoproteica_bagre → D001_bagre_racao_isoproteica | Curadoria aprovada; preparo aprovado; integração local autorizada; check e autorização da fonte pendentes | 11/10/2026 | D001 |

## Planilha de acompanhamento

Por solicitação do professor em 11/10/2026, o acompanhamento passa a usar também
`EAPADados/nova_estetegia_levantamento/balanco_fase2_60_conjuntos.xlsx`.
Essa autorização permite atualizar o acompanhamento, sem alterar dados,
documentação ou decisões anteriores do EAPADados.

- **Dados prontos**: conjunto, análises úteis, data de conclusão, identificador
  permanente no formato `D001`, `D002`, ... e nome anterior/origem.
- Um conjunto só entra nessa aba após aprovação, documentação e validação na
  ClaRa. A linha correspondente recebe preenchimento verde `#C6E0B4` em
  **Núcleo 60** e **Inventário**; as novas colunas registram a situação, o
  identificador e a data sem substituir avaliações anteriores.
- Bases em `dados_treino/` e rótulos históricos como “pronto” ou “já ajustado”
  não equivalem a incorporação aprovada na ClaRa. Nesta etapa não há conjuntos
  concluídos pelo novo fluxo na primeira revisão. A aprovação posterior dos
  bagres está registrada na ficha; autorização e integração são acompanhadas
  separadamente.
- `acompanhamento/` guarda a cópia do balanço anterior à primeira edição.

## Limite desta etapa

Autorizado o preparo dos bagres após a avaliação. O objeto e o catálogo estão
em `data/`; nenhuma função de análise foi alterada. O professor autorizou a integração local na `main`; o check de instalação
permanece pendente e não houve push. O trabalho está na branch `dados`, na pasta separada
`ClaRa-dados/`, iniciada na `main` local `44cb0fe` para incluir o estado local
mais recente sem trocar a branch da pasta compartilhada `ClaRa/`.
