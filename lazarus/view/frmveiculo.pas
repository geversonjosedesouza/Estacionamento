unit frmveiculo;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, SQLDB, DB, IBConnection, Forms, Controls, Graphics,
  Dialogs, StdCtrls, ExtCtrls, DBCtrls, Buttons, DBGrids, ZConnection, ZDataset,
  ZSqlUpdate, TAIntervalSources;

type

  { TFormVeiculo }

  TFormVeiculo = class(TForm)
    dsTIPOS_TEMPO: TDataSource;
    dblcbTABELA_PRECOS_ID: TDBLookupComboBox;
    dsVEICULOS: TDataSource;
    dbckATIVO: TDBCheckBox;
    dbeDESCRICAO: TDBEdit;
    dbgVeiculos: TDBGrid;
    dbnVeiculos: TDBNavigator;
    dbID: TDBText;
    pnlDados: TPanel;
    pnlForm: TPanel;
    pnlVeiculos: TPanel;
    stxtDESCRICAO: TStaticText;
    stxtTABELA_PRECOS_ID: TStaticText;
    stxtID: TStaticText;
    zcESTACIONAMENTO: TZConnection;
    zqTIPOS_TEMPO: TZQuery;
    zqVEICULOS: TZQuery;
    zuVEICULOS: TZUpdateSQL;
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

