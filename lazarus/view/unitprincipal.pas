unit unitPrincipal;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ComCtrls, Menus,
  Buttons, ExtCtrls, ZConnection, ZDataset
  , unitCampoUtils, DB, LCLType
  //Fromulários
  , unitVeiculo, unitTipoTempo, unitTabelaPreco, unitCaixa, unitRegistroVeiculo
  //,unitLogin
  ;

type

  { TFormPrincipal }

  TFormPrincipal = class(TForm)
    bbtnEntrar: TBitBtn;
    imgLogo: TImage;
    ledSenha: TLabeledEdit;
    ledUsuario: TLabeledEdit;
    mniTabelaPreco: TMenuItem;
    mniTiposTempo: TMenuItem;
    mmPrincipal: TMainMenu;
    mniSair: TMenuItem;
    mniEntradaSaida: TMenuItem;
    mniCaixa: TMenuItem;
    mniVeiculos: TMenuItem;
    mniCadastro: TMenuItem;
    mniOperacoes: TMenuItem;
    pnlLogin: TPanel;
    zcEstacionamento: TZConnection;
    zroqLogar: TZReadOnlyQuery;
    zroqLogarATIVO: TStringField;
    zroqLogarDATA_CADASTRO: TDateTimeField;
    zroqLogarID: TLongintField;
    zroqLogarLOGIN: TStringField;
    zroqLogarSENHA: TStringField;
    procedure bbtnEntrarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure ledSenhaKeyPress(Sender: TObject; var Key: char);
    procedure ledUsuarioKeyPress(Sender: TObject; var Key: char);
    procedure mniCaixaClick(Sender: TObject);
    procedure mniEntradaSaidaClick(Sender: TObject);
    procedure mniSairClick(Sender: TObject);
    procedure mniTabelaPrecoClick(Sender: TObject);
    procedure mniTiposTempoClick(Sender: TObject);
    procedure mniVeiculosClick(Sender: TObject);
  private
    usuario: string;
    campoUtils: TCampoUtils;
    procedure Criticas;

  public
    constructor Create(AOwner: TComponent; login: string = 'Não autenticado'); overload;

  end;

var
  FormPrincipal: TFormPrincipal;

implementation

{$R *.lfm}

{ TFormPrincipal }

procedure TFormPrincipal.mniSairClick(Sender: TObject);
begin
  FormPrincipal.Close;
end;

procedure TFormPrincipal.mniCaixaClick(Sender: TObject);
begin
  FormCaixa := TFormCaixa.Create(Self, usuario);
  FormCaixa.Show;
end;

procedure TFormPrincipal.FormShow(Sender: TObject);
begin
  Self.Text := 'Login - Estacionanmento';
  Self.Menu := nil;
  Self.BorderIcons := [biSystemMenu];
  Self.Height := pnlLogin.Height;
  Self.Width := pnlLogin.Width;
end;

procedure TFormPrincipal.ledSenhaKeyPress(Sender: TObject; var Key: char);
begin
  if Key = #13 then
  begin
    Criticas;
    ledSenha.SetFocus;
  end;
end;

procedure TFormPrincipal.ledUsuarioKeyPress(Sender: TObject; var Key: char);
begin
  if Key = #13 then
  begin
    Criticas;
    ledSenha.SetFocus;
  end;
end;

procedure TFormPrincipal.bbtnEntrarClick(Sender: TObject);
begin
  Criticas;
  zroqLogar.Close;
  zroqLogar.ParamByName('pLOGIN').Value := ledUsuario.Text;
  zroqLogar.Open;
  if not (zroqLogarLOGIN.IsNull) then
  begin
    Self.Text := 'Principal - Estacionanmento';
    Self.Menu := mmPrincipal;
    Self.BorderIcons := [biSystemMenu, biMinimize];
    Self.WindowState := wsMaximized;
    usuario := zroqLogarLOGIN.AsString;
    pnlLogin.Visible := False;
  end;
end;

procedure TFormPrincipal.mniEntradaSaidaClick(Sender: TObject);
begin
  FormRegistroVeiculo := TFormRegistroVeiculo.Create(Self, usuario);
  FormRegistroVeiculo.Show;
end;

procedure TFormPrincipal.mniTabelaPrecoClick(Sender: TObject);
begin
  FormTabelaPreco := TFormTabelaPreco.Create(Self, usuario);
  FormTabelaPreco.Show;
end;

procedure TFormPrincipal.mniTiposTempoClick(Sender: TObject);
begin
  FormTipoTempo := TFormTipoTempo.Create(Self, usuario);
  FormTipoTempo.Show;
end;

procedure TFormPrincipal.mniVeiculosClick(Sender: TObject);
begin
  FormVeiculo := TFormVeiculo.Create(Self, usuario);
  FormVeiculo.Show;
end;

procedure TFormPrincipal.Criticas;
var
  intOk: integer = 0;
begin
  if (ledUsuario.Text = '') then
    intOk := Application.MessageBox('Informe o usuário!', 'Atenção',
      MB_ICONEXCLAMATION);
  if (ledSenha.Text = '') then
    intOk := Application.MessageBox('Informe a senha!', 'Atenção', MB_ICONEXCLAMATION);
  if intOk <> 0 then
    Abort;
end;

constructor TFormPrincipal.Create(AOwner: TComponent; login: string);
begin
  inherited Create(AOwner);
  campoUtils := TCampoUtils.Create;
  usuario := login;
end;

end.
