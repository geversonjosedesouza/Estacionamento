unit unitTabelaPreco;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, DBGrids, DBCtrls,
  StdCtrls, ExtCtrls, ZConnection, ZDataset, ZSqlUpdate, DB, SQLDB, LCLType,
  TAChartLiveView;

type

  { TFormTabelaPreco }

  TFormTabelaPreco = class(TForm)
    dsTIPOS_TEMPO: TDataSource;
    dbcAtivo: TDBCheckBox;
    dbeQuantidade: TDBEdit;
    dbeValor: TDBEdit;
    dbgTabelaPrecos: TDBGrid;
    dblcbTiposTempo: TDBLookupComboBox;
    DBNavigator1: TDBNavigator;
    dbtId: TDBText;
    dsTabelaPrecos: TDataSource;
    lblId: TLabel;
    lblQuantidade: TLabel;
    lblTipoTempo: TLabel;
    lblValor: TLabel;
    pnlTabelaPrecos: TPanel;
    pnlDados: TPanel;
    pnlForm: TPanel;
    zcEstacionamento: TZConnection;
    zqTabelaPrecos: TZQuery;
    zqTiposTempo: TZQuery;
    zusqlTabelaPreco: TZUpdateSQL;
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure zqTabelaPrecosAfterInsert(DataSet: TDataSet);
    procedure zqTabelaPrecosAfterPost(DataSet: TDataSet);
    procedure zqTabelaPrecosBeforePost(DataSet: TDataSet);
  private
    usuario: String;
    procedure Criticas;
  public
    constructor Create(AOwner: TComponent;  login: String); overload;

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

procedure TFormTabelaPreco.zqTabelaPrecosAfterInsert(DataSet: TDataSet);
begin
  zqTabelaPrecos.FieldByName('USUARIO').Value := usuario;
end;

procedure TFormTabelaPreco.zqTabelaPrecosAfterPost(DataSet: TDataSet);
begin
  dbgTabelaPrecos.DataSource.DataSet.Refresh;
end;

procedure TFormTabelaPreco.zqTabelaPrecosBeforePost(DataSet: TDataSet);
begin
  Criticas();
end;

procedure TFormTabelaPreco.Criticas;
var
  intOk: integer = 0;
begin
  if (dbeQuantidade.Field.Value = null) then
     intOk:= Application.MessageBox('Informe uma quantidade!', 'Atenção', MB_ICONEXCLAMATION);
  if (dbeValor.Field.Value = null) then
     intOk:= Application.MessageBox('Informe um valor!', 'Atenção', MB_ICONEXCLAMATION);
  if (dblcbTiposTempo.Field.Value = null) then
     intOk:= Application.MessageBox('Selecione um tempo!', 'Atenção', MB_ICONEXCLAMATION);
  if (dbcAtivo.Field.Value = null) then
     intOk:= Application.MessageBox('Marque o status do preço a ser criado!', 'Atenção', MB_ICONEXCLAMATION);
  if intOk <> 0 then
     Abort;
end;

constructor TFormTabelaPreco.Create(AOwner: TComponent; login: String);
begin
  inherited Create(AOwner);
  usuario:= login;
end;

end.
