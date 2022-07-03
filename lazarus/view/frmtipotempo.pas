unit frmtipotempo;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, DBGrids, DBCtrls,
  StdCtrls, ExtCtrls, ZConnection, ZDataset, ZSqlUpdate, ZIBEventAlerter, DB, LCLType;

type

  { TFormTipoTempo }

  TFormTipoTempo = class(TForm)
    dsTiposTempo: TDataSource;
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
    zcEstacionamento: TZConnection;
    zqTiposTempo: TZQuery;
    zuTiposTempo: TZUpdateSQL;
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure zqTiposTempoAfterInsert(DataSet: TDataSet);
    procedure zqTiposTempoAfterPost(DataSet: TDataSet);
    procedure zqTiposTempoBeforePost(DataSet: TDataSet);
  private
    usuario: string;
    procedure Criticas;

  public
    constructor Create(AOwner: TComponent; login: string); overload;

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

procedure TFormTipoTempo.zqTiposTempoAfterInsert(DataSet: TDataSet);
begin
  zqTiposTempo.FieldByName('USUARIO').Value := usuario;
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

constructor TFormTipoTempo.Create(AOwner: TComponent; login: string);
begin
  inherited Create(AOwner);
  usuario := login;
end;

end.

