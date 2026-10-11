# D09_tilapia_sensorial — Tilápia: avaliação sensorial de filés

- Código D09; objeto definitivo `tilapia_sensorial`; sem objeto anterior no EAPADados.
- 122 × 7; uma linha por avaliador, seis notas pareadas, dois atributos.
- Natureza: real, conforme fonte. Origem: Rucinque, Viegas, Lapa-Guimarães,
  Ferreira e Leme (2020), Mendeley Data, versão 5, DOI 10.17632/knsz9r4vby.5.
- Artigo: DOI 10.1016/j.aquaculture.2020.735902. Licença CC BY 4.0,
  confirmada no repositório em 11/10/2026. Manter créditos e adaptações.
- Situação provisória; passada 1 autorizada em 11/10/2026.

## De-para e linhas

Todos os nomes e valores da aba sensorial da planilha organizada existente
foram preservados, incluindo as 122 linhas na mesma ordem. Identificador
`id_avaliador`: número → texto; seis notas: número → inteiro, sem mudar
valores de -3 a +3. Nenhuma exclusão, imputação, conversão de escala ou
alteração de categorias. Fonte XLSX completa intocada, com documentação e SHA256.

## Uso didático

## Conferência da passada 1

A leitura preserva as 122 × 7 células de dados da aba sensorial; as seis
medidas foram conferidas antes/depois da tipagem e o identificador não tem
repetições. Não há NA. O xz ocupa 848 bytes. Com nove conjuntos e catálogo,
`data/` soma 46.216 bytes (0,046 MB decimal). A suíte completa passou nas
271 expectativas, sem falhas, erros, avisos ou skips. Os nove exemplos de
ajuda foram executados e todos os hashes das fontes conferidos.

O build parcial passou. O check parcial parou na instalação por falta dos
oito arquivos novos de documentação no Collate do DESCRIPTION. A inclusão
foi consultada ao professor porque o prompt proíbe alterar esse campo.
Permanece também a violação de acesso preexistente ao encerrar o R depois
dos resultados. Logs e produtos estão fora do repositório.

## Análises

Friedman para comparar três tratamentos de um atributo; Wilcoxon pareado
para uma comparação planejada entre dois tratamentos; preparo largo/longo.
Aroma e sabor são analisados separadamente. Aguarda verbo da ClaRa para
Friedman; o exemplo só resume as notas.

## Pendências para a curadoria

Confirmar âncoras, significado do zero e sentido da escala; não classificá-la
como hedônica nem interpretar notas maiores como aceitação maior antes disso.
Conferir a extração da planilha organizada contra o arquivo do depósito
original, que não foi localizado entre as fontes locais. Nenhum objeto
anterior do EAPADados existe para comparar. Não inferir independência entre
as notas do mesmo avaliador. Curadoria fina e homologação ficam para a passada 2.

## Revisão rápida do autor — 11/10/2026

Cópia `tilapia_sensorial_para_revisao.xlsx`, com abas Dados para revisar, Revisão do autor e documentacao. As 122 linhas e sete colunas da tabela-fonte foram conferidas, sem alteração de valores ou ordem. Campos de resposta do autor em amarelo; aguardam significado da escala e decisão de curadoria. A cópia não é fonte do objeto R enquanto as decisões não forem explicitamente aplicadas.
