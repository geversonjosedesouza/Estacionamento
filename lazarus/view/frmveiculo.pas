unit frmveiculo;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, SQLDB, IBConnection, Forms, Controls, Graphics, Dialogs,
  StdCtrls, ExtCtrls, TAIntervalSources;

type

  { TFormVeiculo }

  TFormVeiculo = class(TForm)
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
  private

  public

  end;

var
  FormVeiculo: TFormVeiculo;

implementation

{$R *.lfm}

{ TFormVeiculo }

procedure TFormVeiculo.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  FormVeiculo.Free;
end;

end.

