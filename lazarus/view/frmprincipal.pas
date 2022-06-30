unit frmPrincipal;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ComCtrls, Menus,
  //Fromulários
  frmveiculo, frmtipotempo, frmtabelapreco, frmcaixa;

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
    procedure mniSairClick(Sender: TObject);
    procedure mniTabelaPrecoClick(Sender: TObject);
    procedure mniTiposTempoClick(Sender: TObject);
    procedure mniVeiculosClick(Sender: TObject);
  private

  public

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
   FormCaixa := TFormCaixa.Create(Application);
   FormCaixa.Show;
end;

procedure TFormPrincipal.mniTabelaPrecoClick(Sender: TObject);
begin
  FormTabelaPreco := TFormTabelaPreco.Create(Application);
  FormTabelaPreco.Show;
end;

procedure TFormPrincipal.mniTiposTempoClick(Sender: TObject);
begin
  FormTipoTempo := TFormTipoTempo.Create(Application);
  FormTipoTempo.Show;
end;

procedure TFormPrincipal.mniVeiculosClick(Sender: TObject);
begin
  FormVeiculo := TFormVeiculo.Create(Application);
  FormVeiculo.Show;
end;

end.

