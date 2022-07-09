SET SQL DIALECT 3;

CREATE GENERATOR GEN_USUARIOS_ID;

CREATE TABLE USUARIOS (
    ID             INTEGER,
    LOGIN          VARCHAR(50) NOT NULL,
    SENHA          VARCHAR(255),
    ATIVO          CHAR(1) NOT NULL,
    DATA_CADASTRO  TIMESTAMP NOT NULL
);

SET TERM ^ ;

CREATE OR ALTER TRIGGER TG_USUARIOS FOR USUARIOS
ACTIVE BEFORE INSERT POSITION 0
as
begin
  if (new.id is null) then
    new.id = gen_id(gen_usuarios_id,1);
end
^


SET TERM ; ^


INSERT INTO USUARIOS
(ID, LOGIN, SENHA, ATIVO, DATA_CADASTRO)
VALUES
(1, 'root', '123456', '1', current_timestamp);
