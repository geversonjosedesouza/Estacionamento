
SET SQL DIALECT 3;

CREATE GENERATOR GEN_TIPOS_TEMPO_ID;

CREATE TABLE TIPOS_TEMPO (
    ID         INTEGER,
    DESCRICAO  VARCHAR(10) NOT NULL,
    ATIVO      CHAR(1) NOT NULL
);

SET TERM ^ ;

/* Trigger: TG_TIPOS_TEMPO */
CREATE OR ALTER TRIGGER TG_TIPOS_TEMPO FOR TIPOS_TEMPO
ACTIVE BEFORE INSERT POSITION 0
as
begin
  if (new.id is null) then
    new.id = gen_id(gen_tipos_tempo_id,1);
end
^


SET TERM ; ^