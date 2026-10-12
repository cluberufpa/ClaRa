# Qualidade da rodada de dados — 12/10/2026

Esta nota organiza a revisão dos dados incorporados ou substituídos. Ela não
mede a qualidade científica de um estudo por um único número: separa
rastreabilidade, fidelidade do preparo, estrutura do delineamento e adequação
ao uso didático. A presença no pacote não autoriza uma análise que ignore os
limites documentados.

## Estados visíveis no catálogo

A coluna `situacao` de `catalogo_dados` passa a usar estes começos de texto nos
registros desta rodada:

- **Pronto para exploração; usar com limite de delineamento:** fonte e preparo
  conferidos, apropriado para carregar, descrever e explorar; a limitação
  indicada continua obrigatória na análise.
- **Provisório para curadoria:** fonte disponível, mas ainda há decisão
  substantiva sobre categorias, estrutura ou interpretação antes de tratá-lo
  como exemplo analítico consolidado.
- **Metadados pendentes:** não usar para atribuir unidade, condição ou unidade
  de medida que a fonte ainda não confirmou.

Esses estados descrevem o uso atual no ensino. Não substituem a licença, a
ficha nem a leitura do delineamento original.

## Registros incorporados ou substituídos

| Grupo de qualidade | Registros | Evidência preservada | Limite que não pode ser apagado |
|---|---|---|---|
| Rastreáveis e prontos para exploração com limite de delineamento | D18 `truta_acidos_graxos`, D44 `percas_hipoxia`, D47 `pollock_alasca`, D48 `molinesias_crescimento`, D61 `larvas_peixes_captura` | Fonte congelada, hash, receita de preparo, de-para e dados/ausências preservados | Respectivamente: poucos aquários por dieta; medidas repetidas; dependência espacial; medidas repetidas; dependência temporal e calendário incompleto. |
| Fonte forte, curadoria analítica ainda pendente | D50 `molinesias_parasitos` | Dryad CC0, arquivo preservado e preparo reprodutível | Local, espécie e sexo não são completamente cruzados; grupos são desbalanceados e colunas derivadas exigem revisão fina. |

O D47 preserva dois pontos que interceptam o contorno terrestre generalizado.
Eles são uma pendência cartográfica, não motivo para deslocar ou excluir linhas.
Os D44 e D48 não receberam verbo analítico novo: a documentação é honesta sobre
a dependência dentro do peixe enquanto a ClaRa não oferece o motor apropriado.

## Histórico das substituições

Os objetos ativos mantêm seus códigos D. As fontes e receitas substituídas são
histórico, não insumo para recriar o catálogo atual:

- D18: `data-raw/substituidos/D18_cabritos_dietas/`;
- D44: `data-raw/substituidos/D44_plantas_absorcao/`;
- D47: `data-raw/substituidos/D47_terremotos_fiji/`;
- D48: `data-raw/substituidos/D48_laranjeiras_crescimento/`;
- D50: `data-raw/substituidos/D50_escolares_ausencias/`.

Após a inclusão de D61, o catálogo contém 61 registros: 52 distribuídos pela
ClaRa, oito lidos do FSAdata e um do MASS. Receitas de substituição verificam
que não alteram a quantidade total de registros; a receita de inclusão do D61
é a única que a aumenta nesta rodada.
