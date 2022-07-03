SELECT
    TP.ID,
    TP.DESCRICAO
FROM
    TIPOS_TEMPO AS TP
WHERE
    TP.ATIVO = 1

    select ('00'||'01') AS TESTE  from  TIPOS_TEMPO

    SELECT
    v.*,
    case when v.ativo = 1 then 'ativo' else 'inativo' end as status
    FROM
VEICULOS AS V


select 
    v.*,
    (tt.descricao || ' - ' || ' - ' || tp.valor) as tabela_preco,
    case when v.ativo = 1 then 'Ativo' else 'Inativo' end as status
from veiculos as v
   inner join tabela_precos as tp on (v.tebela_precos_id = tp.id)
   inner join tipos_tempo as tt on (tp.tipos_tempo_id = tt.id)


select
    tp.id,
    (tp.quantidade || ' - ' ||
    tt.descricao || ' - ' ||
    tp.valor
    ) AS DESCRICAO
from tabela_precos as tp
   inner join tipos_tempo as tt on (tp.tipos_tempo_id = tt.id)
   where
   tp.ativo = 1
   and tt.ativo = 1

   /*
INSERT INTO REGISTROS_VEICULOS
(ID, ENTRADA, SAIDA, VEICULOS_ID, CAIXAS_ID, PLACA, VALOR, ATIVO)
VALUES
(gen_id(gen_registros_veiculos_id,1), '3-JUL-2022 00:00:00', '3-JUL-2022 00:00:00', 5, 5, '123456', 2, 'S');
*/
select * from registros_veiculos as rv;
select SUM(rv.valor) as valor_fechamento from registros_veiculos as rv
inner join caixas as c on (c.id = rv.caixas_id)
where    rv.ativo = 'S'  and
rv.caixas_id=1
