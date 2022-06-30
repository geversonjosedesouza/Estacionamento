unit frmtipotempo;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, DBGrids, DBCtrls,
  StdCtrls, ExtCtrls, ZConnection, ZDataset, ZSqlUpdate, ZIBEventAlerter, DB, LCLType;

type

  { TFormTipoTempo }

  TFormTipoTempo = class(TForm)
    DataSource1: TDataSource;
    dbcAtivo: TDBCheckBox;
    dbeDescricao: TDBEdit;
    dbgTipoTempo: TDBGrid;
    DBNavigator1: TDBNavigator;
    dbtId: TDBText;
    lblDescricao: TLabel;
    lblId: TLabel;
    pnlDados: TPanel;
    pnlTipoTempo: TPanel;
    pnlForm: TPanel;
    ZConnection1: TZConnection;
    zqTiposTempo: TZQuery;
    ZUpdateSQL1: TZUpdateSQL;
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure zqTiposTempoAfterPost(DataSet: TDataSet);
    procedure zqTiposTempoBeforePost(DataSet: TDataSet);
  private
    procedure Criticas;

  public

  end;

var
  FormTipoTempo: TFormTipoTempo;

implementation

{$R *.lfm}

{ TFormTipoTempo }

procedure TFormTipoTempo.FormClose(Sender: TObject;
  var CloseAction: TCloseAction);
begin
    FormTipoTempo.Free;
end;

procedure TFormTipoTempo.zqTiposTempoAfterPost(DataSet: TDataSet);
begin
  dbgTipoTempo.DataSource.DataSet.Refresh;
end;

procedure TFormTipoTempo.zqTiposTempoBeforePost(DataSet: TDataSet);
begin
     Criticas;
end;

procedure TFormTipoTempo.Criticas;
var
  intOk: integer = 0;
begin
  if (dbeDescricao.Field.Value = null) then
     intOk:= Application.MessageBox('Informe a descrição!', 'Atenção', MB_ICONEXCLAMATION);
  if (dbcAtivo.Field.Value = null) then
     intOk:= Application.MessageBox('Marque o status do tipo do tempo a ser criado!', 'Atenção', MB_ICONEXCLAMATION);
  if intOk <> 0 then
     Abort;
end;

end.

