unit frmtabelapreco;

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
    Panel1: TPanel;
    pnlDados: TPanel;
    pnlForm: TPanel;
    zcEstacionamento: TZConnection;
    zqTabelaPrecos: TZQuery;
    zqTiposTempo: TZQuery;
    zusqlTabelaPreco: TZUpdateSQL;
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure zqTabelaPrecosAfterPost(DataSet: TDataSet);
    procedure zqTabelaPrecosBeforeDelete(DataSet: TDataSet);
    procedure zqTabelaPrecosBeforePost(DataSet: TDataSet);
  private
    procedure Criticas;
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

procedure TFormTabelaPreco.zqTabelaPrecosAfterPost(DataSet: TDataSet);
begin
  dbgTabelaPrecos.DataSource.DataSet.Refresh;
end;

procedure TFormTabelaPreco.zqTabelaPrecosBeforeDelete(DataSet: TDataSet);
begin
     if IDNO = Application.MessageBox('Tem certeza que deseja excluir?', 'Atenção', MB_ICONQUESTION + MB_YESNO) then
        Abort;
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

end.
