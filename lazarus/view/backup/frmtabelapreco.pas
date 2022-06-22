unit frmtabelapreco;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, DBGrids, DBCtrls,
  StdCtrls, ZConnection, ZDataset, ZSqlUpdate, DB;

type

  { TFormTabelaPreco }

  TFormTabelaPreco = class(TForm)
    dbeTipoTempo: TDBEdit;
    dsTabelaPrecos: TDataSource;
    dbcAtivo: TDBCheckBox;
    dbeQuantidade: TDBEdit;
    dbeValor: TDBEdit;
    DBGrid1: TDBGrid;
    DBNavigator1: TDBNavigator;
    dbtId: TDBText;
    lblQuantidade: TLabel;
    lblId: TLabel;
    lblValor: TLabel;
    lblTipoTempo: TLabel;
    zcEstacionamento: TZConnection;
    zqTabelaPrecos: TZQuery;
    zusqlTabelaPreco: TZUpdateSQL;
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
  private

  public

  end;

var
  FormTabelaPreco: TFormTabelaPreco;

implementation

{$R *.lfm}

{ TFormTabelaPreco }

procedure TFormTabelaPreco.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  FormTabelaPreco.Free;
end;

end.

