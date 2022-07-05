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
select * from  caixas as cregistros_veiculos as rv;
select SUM(rv.valor) as valor_fechamento from
inner joinregistros_veiculos as rv on (c.id = rv.caixas_id)
where    rv.ativo = 'S'  and
rv.caixas_id=1

--Registros Veículos
SELECT rv.*,
        v.descricao,
       CASE
           WHEN rv.ativo = 1 THEN 'Ativo'
           ELSE 'Inativo'
       END AS status,
       c.*
FROM registros_veiculos AS rv
right JOIN caixas AS c ON (c.id = rv.caixas_id)
right JOIN veiculos AS v ON (v.id = rv.veiculos_id)
WHERE c.data_abertura IS NOT NULL
  AND c.data_fechamento IS NULL

 --Veículos
 select * from tabela_precos as tp;
  select * from tipos_tempo as tt;
 select 
    v.id,
    (v.descricao || ' - ' || tt.descricao) as descricao
from veiculos as v
   inner join tabela_precos as tp on (v.tebela_precos_id = tp.id and v.ativo = tp.ativo)
   inner join tipos_tempo as tt on (tp.tipos_tempo_id = tt.id and v.ativo = tt.ativo)
   where v.ativo = '1'

 select * from caixas AS c
WHERE c.data_abertura IS NOT NULL
  AND c.data_fechamento IS NULL





  SELECT c.ID
FROM caixas AS c
WHERE c.data_abertura IS NOT NULL
  AND c.data_fechamento IS NULL

SELECT rv.entrada,
       datediff (HOUR
                 FROM rv.entrada TO CURRENT_TIMESTAMP) AS tempo ,
       tp.valor ,
       (tp.quantidade * tp.valor) AS valor_tempo ,
       (datediff (HOUR
                  FROM rv.entrada TO CURRENT_TIMESTAMP) * (tp.quantidade * tp.valor)) AS valor_pagar
FROM registros_veiculos AS rv
INNER JOIN veiculos AS v ON (v.id = rv.veiculos_id
                             AND rv.ativo = v.ativo)
INNER JOIN tabela_precos AS tp ON (tp.id = v.tebela_precos_id
                                   AND v.ativo = tp.ativo)
INNER JOIN tipos_tempo AS tt ON (tp.tipos_tempo_id = tt.id
                                 AND v.ativo = tt.ativo)
WHERE rv.ativo = '1'
  AND rv.saida IS NULL
  AND (rv.ID = 0
       OR rv.PLACA = 'TESTE1');




       SELECT rv.entrada,
       datediff (HOUR
                 FROM rv.entrada TO CURRENT_TIMESTAMP) AS tempo ,
       tp.valor ,
       (tp.quantidade * tp.valor) AS valor_tempo ,
       (datediff (HOUR
                  FROM rv.entrada TO CURRENT_TIMESTAMP) * (tp.quantidade * tp.valor)) AS valor_pagar
FROM registros_veiculos AS rv
INNER JOIN veiculos AS v ON (v.id = rv.veiculos_id
                             AND rv.ativo = v.ativo)
INNER JOIN tabela_precos AS tp ON (tp.id = v.tebela_precos_id
                                   AND v.ativo = tp.ativo)
INNER JOIN tipos_tempo AS tt ON (tp.tipos_tempo_id = tt.id
                                 AND v.ativo = tt.ativo)
SELECT rv.entrada,
       datediff (HOUR
                 FROM rv.entrada TO CURRENT_TIMESTAMP) AS tempo ,
       tp.valor ,
       (tp.quantidade * tp.valor) AS valor_tempo ,
       (datediff (HOUR
                  FROM rv.entrada TO CURRENT_TIMESTAMP) * (tp.quantidade * tp.valor)) AS valor_pagar
FROM registros_veiculos AS rv
INNER JOIN veiculos AS v ON (v.id = rv.veiculos_id
                             AND rv.ativo = v.ativo)
INNER JOIN tabela_precos AS tp ON (tp.id = v.tebela_precos_id
                                   AND v.ativo = tp.ativo)
INNER JOIN tipos_tempo AS tt ON (tp.tipos_tempo_id = tt.id
                                 AND v.ativo = tt.ativo)
WHERE rv.ativo = '1'
  AND rv.saida IS NULL
  and rv.CAIXAS_ID = :pCAIXA
  AND (rv.ID = :pID
       OR rv.PLACA =:pPLACA)


