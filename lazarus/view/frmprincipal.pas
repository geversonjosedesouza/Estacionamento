unit frmPrincipal;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ComCtrls, Menus,
  //Fromulários
  frmveiculo, frmtipotempo, frmtabelapreco, frmcaixa, frmregistroveiculo;

type

  { TFormPrincipal }

  TFormPrincipal = class(TForm)
    mniTabelaPreco: TMenuItem;
    mniTiposTempo: TMenuItem;
    mmPrincipal: TMainMenu;
    mniSair: TMenuItem;
    mniEntradaSaida: TMenuItem;
    mniCaixa: TMenuItem;
    mniVeiculos: TMenuItem;
    mniCadastro: TMenuItem;
    mniOperacoes: TMenuItem;
    procedure mniCaixaClick(Sender: TObject);
    procedure mniEntradaSaidaClick(Sender: TObject);
    procedure mniSairClick(Sender: TObject);
    procedure mniTabelaPrecoClick(Sender: TObject);
    procedure mniTiposTempoClick(Sender: TObject);
    procedure mniVeiculosClick(Sender: TObject);
  private
    usuario: string;

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

constructor TFormPrincipal.Create(AOwner: TComponent; login: string);
begin
  inherited Create(AOwner);
  usuario := login;
end;

end.

