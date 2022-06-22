unit frmtipotempo;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, DBGrids, DBCtrls,
  StdCtrls, ZConnection, ZDataset, ZSqlUpdate, ZIBEventAlerter, DB;

type

  { TFormTipoTempo }

  TFormTipoTempo = class(TForm)
    DataSource1: TDataSource;
    dbcAtivo: TDBCheckBox;
    dbeDescricao: TDBEdit;
    DBGrid1: TDBGrid;
    DBNavigator1: TDBNavigator;
    dbtId: TDBText;
    lblDescricao: TLabel;
    lblId: TLabel;
    ZConnection1: TZConnection;
    ZQuery1: TZQuery;
    ZUpdateSQL1: TZUpdateSQL;
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
  private

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

end.
