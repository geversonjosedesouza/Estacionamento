program estacionamento;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}
  cthreads,
  {$ENDIF}
  {$IFDEF HASAMIGA}
  athreads,
  {$ENDIF}
  Interfaces, // this includes the LCL widgetset
  Forms, zcomponent, tachartlazaruspkg, frmPrincipal, frmveiculo, frmtipotempo,
  frmtabelapreco, frmcaixa
  { you can add units after this };

{$R *.res}

begin
  RequireDerivedFormResource:=True;
  Application.Scaled:=True;
  Application.Initialize;
  Application.CreateForm(TFormPrincipal, FormPrincipal);
  Application.CreateForm(TFormVeiculo, FormVeiculo);
  Application.CreateForm(TFormTipoTempo, FormTipoTempo);
  Application.CreateForm(TFormTabelaPreco, FormTabelaPreco);
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.

