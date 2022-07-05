unit frmregistroveiculo;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, DBCtrls, ExtCtrls,
  DBGrids, StdCtrls, ZConnection, ZDataset, ZSqlUpdate, DB, LCLType, unitCampoUtils,  strutils;

type

  { TFormRegistroVeiculo }

  TFormRegistroVeiculo = class(TForm)
    btnPagar: TButton;
    dsPagar: TDataSource;
    dbeValor: TDBEdit;
    dbePLACA: TDBEdit;
    dblcbVeiculos: TDBLookupComboBox;
    dsRegistroVeiculo: TDataSource;
    dbgRegistroVeiculos: TDBGrid;
    dbnControles: TDBNavigator;
    dsVeiculos: TDataSource;
    edtCodigo: TEdit;
    edtDinheiro: TEdit;
    edtPlaca: TEdit;
    gbEntrada: TGroupBox;
    gbSaida: TGroupBox;
    lblTipoTempo: TLabel;
    lblPlaca: TLabel;
    pnlDados: TPanel;
    pnlForm: TPanel;
    pnlRegistroVeiculos: TPanel;
    stxtCodigo1: TStaticText;
    stxtCodigo2: TStaticText;
    stxtPlaca: TStaticText;
    stxtCodigo: TStaticText;
    zcESTACIONAMENTO: TZConnection;
    zqRegistroVeiculo: TZQuery;
    zqVeiculos: TZQuery;
    zroqCaixaAbero: TZReadOnlyQuery;
    zroqPagar: TZReadOnlyQuery;
    zroqCaixaAberoID: TLongintField;
    zroqPagarENTRADA: TDateTimeField;
    zroqPagarID: TLongintField;
    zroqPagarTEMPO: TLargeintField;
    zroqPagarVALOR: TFloatField;
    zroqPagarVALOR_PAGAR: TFloatField;
    zroqPagarVALOR_TEMPO: TFloatField;
    zusRegistroVeiculo: TZUpdateSQL;
    procedure btnPagarClick(Sender: TObject);
    procedure edtDinheiroKeyPress(Sender: TObject; var Key: char);
    procedure edtCodigoKeyPress(Sender: TObject; var Key: char);
    procedure edtPlacaKeyPress(Sender: TObject; var Key: char);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure zqRegistroVeiculoAfterInsert(DataSet: TDataSet);
    procedure zqRegistroVeiculoAfterPost(DataSet: TDataSet);
    procedure zqRegistroVeiculoBeforePost(DataSet: TDataSet);
  private
    usuario: string;
    campoUtils: TCampoUtils;
    procedure Criticas;
    procedure ConsultarVeiculo;

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

procedure TFormRegistroVeiculo.btnPagarClick(Sender: TObject);
begin
  zqRegistroVeiculo.Locate('ID', zroqPagar.FieldByName('ID').Text, [loCaseInsensitive, loPartialKey]);
  zqRegistroVeiculo.Edit;
  zqRegistroVeiculo.FieldByName('SAIDA').Value := Now;
  zqRegistroVeiculo.FieldByName('VALOR').Value := StrToFloat(dbeValor.Text);
  zqRegistroVeiculo.Post;
  btnPagar.Enabled:= False;
  edtDinheiro.Clear;
  edtPlaca.Clear;
  edtCodigo.Clear;
  edtCodigo.SetFocus;
end;

procedure TFormRegistroVeiculo.edtDinheiroKeyPress(Sender: TObject; var Key: char
  );
var
  valor: double;
begin
  if Key = #13 then
  begin
    if (edtDinheiro.Text <> '') then
    begin
      valor := StrToFloat(edtDinheiro.Text) - StrToFloat(dbeValor.Text);
      if (valor >= 0) then
      begin
        btnPagar.Enabled := True;
      end
      else
      begin
        Application.MessageBox('Valor informado é menor que o valor a pagar!',
          'Atenção', MB_ICONEXCLAMATION);
      end;
    end;
  end
  else
  begin
    Key := campoUtils.SomenteNumeros(Key, edtDinheiro.Text);
  end;
end;

procedure TFormRegistroVeiculo.edtCodigoKeyPress(Sender: TObject; var Key: char
  );
begin
  if Key = #13 then
  begin
    ConsultarVeiculo;
  end
  else
  begin
    Key := campoUtils.SomenteNumeros(Key, edtCodigo.Text);
  end;
end;

procedure TFormRegistroVeiculo.edtPlacaKeyPress(Sender: TObject; var Key: char);
begin
  if Key = #13 then
  begin
    ConsultarVeiculo;
  end
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
    intOk := Application.MessageBox('Informe o veículo!', 'Atenção',
      MB_ICONEXCLAMATION);
  if intOk <> 0 then
    Abort;
end;

procedure TFormRegistroVeiculo.ConsultarVeiculo;
begin
  zroqPagar.Close;
  zroqPagar.ParamByName('pCAIXA').Value := zroqCaixaAberoID.Value;
  zroqPagar.ParamByName('pID').Value := StrToInt64(IfThen(edtCodigo.Text <> '', edtCodigo.Text, '0'));
  zroqPagar.ParamByName('pPLACA').Value := edtPlaca.Text;
  zroqPagar.Open;
  if (zroqPagar.FieldByName('VALOR_PAGAR').IsNull) then
  begin
    edtDinheiro.Enabled := False;
  end
  else
  begin
    edtDinheiro.Enabled := True;
  end;
end;

constructor TFormRegistroVeiculo.Create(AOwner: TComponent; login: string);
begin
  inherited Create(AOwner);
  usuario := login;
  campoUtils := TCampoUtils.Create;
end;

end.
