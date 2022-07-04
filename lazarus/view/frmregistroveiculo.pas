unit frmregistroveiculo;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, DBCtrls, ExtCtrls,
  DBGrids, StdCtrls, ZConnection, ZDataset, ZSqlUpdate, DB, LCLType;

type

  { TFormRegistroVeiculo }

  TFormRegistroVeiculo = class(TForm)
    Button1: TButton;
    dbePLACA: TDBEdit;
    dblcbVeiculos: TDBLookupComboBox;
    dsRegistroVeiculo: TDataSource;
    dbgRegistroVeiculos: TDBGrid;
    dbnControles: TDBNavigator;
    dsVeiculos: TDataSource;
    lblTipoTempo: TLabel;
    pnlDados: TPanel;
    pnlForm: TPanel;
    pnlRegistroVeiculos: TPanel;
    stxtPlaca: TStaticText;
    zcESTACIONAMENTO: TZConnection;
    zqRegistroVeiculo: TZQuery;
    zqVeiculos: TZQuery;
    zroqCaixaAbero: TZReadOnlyQuery;
    zroqCaixaAberoID: TLongintField;
    zusRegistroVeiculo: TZUpdateSQL;
    procedure Button1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure zqRegistroVeiculoAfterInsert(DataSet: TDataSet);
    procedure zqRegistroVeiculoAfterPost(DataSet: TDataSet);
    procedure zqRegistroVeiculoBeforePost(DataSet: TDataSet);
  private
    usuario: string;
    procedure Criticas;

  public
    constructor Create(AOwner: TComponent; login: string); overload;

  end;

var
  FormRegistroVeiculo: TFormRegistroVeiculo;

implementation

{$R *.lfm}

{ TFormRegistroVeiculo }

procedure TFormRegistroVeiculo.FormClose(Sender: TObject;
  var CloseAction: TCloseAction);
begin
  FormRegistroVeiculo.Free;
end;

procedure TFormRegistroVeiculo.Button1Click(Sender: TObject);
var
  valor: string;
begin
  if (zqRegistroVeiculo.State = dsEdit) then
  begin
    if (InputQuery('Realizando Pagamento', 'Digite o valor', valor)) then
    begin
      zqRegistroVeiculo.FieldByName('SAIDA').Value := Now;
      zqRegistroVeiculo.FieldByName('VALOR').Value := StrToFloat(valor);
      zqRegistroVeiculo.Post;
    end;
  end;
end;

procedure TFormRegistroVeiculo.FormCreate(Sender: TObject);
begin
  zroqCaixaAbero.Open;
  if (zroqCaixaAberoID.IsNull) then
  begin
    Application.MessageBox(
      'Não há caixa aberto, vá para a tela de abertura de caixa para proseguir com as operações do dia!',
      'Atenção', MB_ICONEXCLAMATION);
    pnlRegistroVeiculos.Enabled := False;
  end;
end;

procedure TFormRegistroVeiculo.zqRegistroVeiculoAfterInsert(DataSet: TDataSet);
begin
  zqRegistroVeiculo.FieldByName('ENTRADA').Value := Now;
  zqRegistroVeiculo.FieldByName('VALOR').Value := 0;
  zqRegistroVeiculo.FieldByName('USUARIO').Value := usuario;
  zqRegistroVeiculo.FieldByName('ATIVO').Value := '1';
  zqRegistroVeiculo.FieldByName('CAIXAS_ID').Value := zroqCaixaAberoID.Value;
end;

procedure TFormRegistroVeiculo.zqRegistroVeiculoAfterPost(DataSet: TDataSet);
begin
    dbgRegistroVeiculos.DataSource.DataSet.Refresh;
end;

procedure TFormRegistroVeiculo.zqRegistroVeiculoBeforePost(DataSet: TDataSet);
begin
  Criticas;
end;

procedure TFormRegistroVeiculo.Criticas;
var
  intOk: integer = 0;
begin
  if (dbePLACA.Field.Value = null) then
    intOk := Application.MessageBox('Informe a placa!', 'Atenção', MB_ICONEXCLAMATION);
  if (dblcbVeiculos.Field.Value = null) then
    intOk := Application.MessageBox('Informe o veículo!', 'Atenção', MB_ICONEXCLAMATION);
  if intOk <> 0 then
     Abort;
end;

constructor TFormRegistroVeiculo.Create(AOwner: TComponent; login: string);
begin
  inherited Create(AOwner);
  usuario:= login;
end;

end.

