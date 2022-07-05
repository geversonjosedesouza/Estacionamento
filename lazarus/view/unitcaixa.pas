unit unitCaixa;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, StdCtrls,
  DBCtrls, DBDateTimePicker, ZDataset, ZConnection, ZSqlUpdate, DB, BufDataset,
  LCLType;

type

  { TFormCaixa }

  TFormCaixa = class(TForm)
    bdsCaixasATIVO: TStringField;
    bdsCaixasDATA_ABERTURA: TDateTimeField;
    bdsCaixasDATA_FECHAMENTO: TDateTimeField;
    bdsCaixasVALOR_ABERTURA: TFloatField;
    bdsCaixasVALOR_FECHAMENTO: TFloatField;
    btnConfirmar: TButton;
    bdsCaixas: TBufDataset;
    DBCheckBox1: TDBCheckBox;
    dbdtpAbertura: TDBDateTimePicker;
    dbdtpFechamento: TDBDateTimePicker;
    dbeValorAbertura: TDBEdit;
    dbeValorFechamento: TDBEdit;
    dsCaixas: TDataSource;
    lblDataFechamento: TLabel;
    lblValorFechamento: TLabel;
    lblValorAbertura: TLabel;
    lblDataAbertura: TLabel;
    lblSituacao: TLabel;
    pnlInfo: TPanel;
    pnlForm: TPanel;
    pnlCaixa: TPanel;
    zcEstacionamento: TZConnection;
    zqCaixas: TZQuery;
    zqCaixasATIVO: TStringField;
    zqCaixasDATA_ABERTURA: TDateTimeField;
    zqCaixasDATA_FECHAMENTO: TDateTimeField;
    zqCaixasID: TLongintField;
    zqCaixasUSUARIO: TStringField;
    zqCaixasVALOR_ABERTURA: TFloatField;
    zqCaixasVALOR_FECHAMENTO: TFloatField;
    zroqFechamento: TZReadOnlyQuery;
    zroqFechamentoVALOR_FECHAMENTO: TFloatField;
    zusqlCaixas: TZUpdateSQL;
    procedure btnConfirmarClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
  private
    usuario: string;
    procedure MovimentarCaixa(Movimento: string);
    procedure Criticas(Movimento: string);

  public
    constructor Create(AOwner: TComponent; login: string); overload;

  end;

var
  FormCaixa: TFormCaixa;

implementation

{$R *.lfm}

{ TFormCaixa }

procedure TFormCaixa.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  FormCaixa.Free;
end;

procedure TFormCaixa.MovimentarCaixa(Movimento: string);
begin
  Criticas(Movimento);
  if (mrYes = Application.MessageBox(PChar('Tem certeza que deseja ' + Movimento + ' o caixa?'), 'Atenção', MB_ICONQUESTION + MB_YESNO)) then
  begin
    if (Movimento = 'Abrir') then
    begin
      zqCaixas.Insert;
      zqCaixasATIVO.Value := bdsCaixasATIVO.Value;
      zqCaixasDATA_ABERTURA.Value := bdsCaixasDATA_ABERTURA.Value;
      zqCaixasVALOR_ABERTURA.Value:= bdsCaixasVALOR_ABERTURA.Value;
      zqCaixasDATA_FECHAMENTO.Clear;
      zqCaixasVALOR_FECHAMENTO.Clear;
    end
    else if (Movimento = 'Fechar') then
    begin
      zqCaixas.Edit;
      zqCaixasATIVO.Value := bdsCaixasATIVO.Value;
      zqCaixasDATA_ABERTURA.Value := bdsCaixasDATA_ABERTURA.Value;
      zqCaixasVALOR_ABERTURA.Value:= bdsCaixasVALOR_ABERTURA.Value;
      zqCaixasDATA_FECHAMENTO.Value := bdsCaixasDATA_FECHAMENTO.Value;
      zqCaixasVALOR_FECHAMENTO.Value := bdsCaixasVALOR_FECHAMENTO.Value;
    end;
    zqCaixasUSUARIO.Value:= usuario;
    zqCaixas.Post;
  end;
end;

procedure TFormCaixa.Criticas(Movimento: string);
var
  intOk: integer = 0;
begin
  if (Movimento = 'Abrir') then
  begin
    if (dbdtpAbertura.Field.Value = null) then
      intOk := Application.MessageBox('Informe a data de abertura!',
        'Atenção', MB_ICONEXCLAMATION);
    if (dbeValorAbertura.Field.Value = null) then
      intOk := Application.MessageBox('Informe o valor de abertura!',
        'Atenção', MB_ICONEXCLAMATION);
  end;
  if (Movimento = 'Fechar') then
  begin
    if (dbdtpFechamento.Field.Value = null) then
      intOk := Application.MessageBox('Informe a data de fechamento!',
        'Atenção', MB_ICONEXCLAMATION);
    if (dbeValorFechamento.Field.Value = null) then
      intOk := Application.MessageBox('Informe o valor de fechamento!',
        'Atenção', MB_ICONEXCLAMATION);
  end;
  if intOk <> 0 then
    Abort;
end;

constructor TFormCaixa.Create(AOwner: TComponent; login: string);
begin
  inherited Create(AOwner);
  usuario := login;
end;

procedure TFormCaixa.FormActivate(Sender: TObject);
begin
  if (zqCaixas.State = dsBrowse) then
  begin
    if (bdsCaixas.State <> dsInsert) then
    begin
      bdsCaixas.CreateDataset;
      bdsCaixas.Insert;
    end;

    if (zqCaixasDATA_ABERTURA.IsNull) then
    begin
      //Info
      lblSituacao.Caption := 'Fechado';
      lblSituacao.Font.Color := clRed;
      //Form
      dbdtpFechamento.Enabled := False;
      dbeValorFechamento.Enabled := False;
      //Dados
      bdsCaixasATIVO.Value := '1';
      bdsCaixasDATA_ABERTURA.Value := Now;
      bdsCaixasVALOR_ABERTURA.Value := 0.00;
      bdsCaixasDATA_FECHAMENTO.Clear;
      bdsCaixasVALOR_FECHAMENTO.Clear;
    end
    else
    begin
      //Info
      lblSituacao.Caption := 'Aberto';
      lblSituacao.Font.Color := clBlue;
      //Form
      dbdtpAbertura.Enabled := False;
      dbeValorAbertura.Enabled := False;
      //Dados
      bdsCaixasATIVO.Value := zqCaixasATIVO.Value;
      bdsCaixasDATA_ABERTURA.Value := zqCaixasDATA_ABERTURA.Value;
      bdsCaixasVALOR_ABERTURA.Value := zqCaixasVALOR_ABERTURA.Value;
      bdsCaixasDATA_FECHAMENTO.Value := Now;
      zroqFechamento.Close;
      zroqFechamento.ParamByName('pCAIXAS_ID').Value := zqCaixasID.Value;
      zroqFechamento.Open;
      bdsCaixasVALOR_FECHAMENTO.Value := (zqCaixasVALOR_ABERTURA.Value + zroqFechamentoVALOR_FECHAMENTO.Value);
    end;
    bdsCaixas.Post;
  end;
end;

procedure TFormCaixa.btnConfirmarClick(Sender: TObject);
begin
  if (lblSituacao.Caption = 'Fechado') then
  begin
    MovimentarCaixa('Abrir');
    Application.MessageBox('Caixa Aberto com sucesso!', 'Operação Realizada', MB_ICONINFORMATION);
  end;
  if (lblSituacao.Caption = 'Aberto') then
  begin
    MovimentarCaixa('Fechar');
    Application.MessageBox('Caixa Fechado com sucesso!', 'Operação Realizada', MB_ICONINFORMATION);
  end;
  btnConfirmar.Enabled := False;
end;

end.
