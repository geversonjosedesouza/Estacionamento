SET SQL DIALECT 3;

CREATE GENERATOR GEN_REGISTROS_VEICULOS_ID;

CREATE TABLE REGISTROS_VEICULOS (
    ID           INTEGER,
    ENTRADA      TIMESTAMP NOT NULL,
    SAIDA        TIMESTAMP,
    VEICULOS_ID  INTEGER NOT NULL,
    CAIXAS_ID    INTEGER NOT NULL,
    PLACA        VARCHAR(8),
    VALOR        DOUBLE PRECISION,
    ATIVO        CHAR(1) NOT NULL
);

SET TERM ^ ;

CREATE OR ALTER TRIGGER TG_REGISTROS_VEICULOS FOR REGISTROS_VEICULOS
ACTIVE BEFORE INSERT POSITION 0
as
begin
  if (new.id is null) then
    new.id = gen_id(gen_registros_veiculos_id,1);
end
^


SET TERM ; ^
