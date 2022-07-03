SET SQL DIALECT 3;


CREATE GENERATOR GEN_CAIXAS_ID;

CREATE TABLE CAIXAS (
    ID                INTEGER,
    DATA_ABERTURA     TIMESTAMP NOT NULL,
    DATA_FECHAMENTO   TIMESTAMP,
    VALOR_ABERTURA    DOUBLE PRECISION NOT NULL,
    VALOR_FECHAMENTO  DOUBLE PRECISION,
    ATIVO             CHAR(1) NOT NULL
);

SET TERM ^ ;

CREATE OR ALTER TRIGGER TG_CAIXAS FOR CAIXAS
ACTIVE BEFORE INSERT POSITION 0
as
begin
  if (new.id is null) then
    new.id = gen_id(gen_caixas_id,1);
end
^


SET TERM ; ^



/******************************************************************************/
/***                               Privileges                               ***/
/******************************************************************************/

