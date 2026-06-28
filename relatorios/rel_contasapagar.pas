unit rel_contasapagar;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, RLReport, db;

type

  { Tfrm_RelContasAPagar }

  Tfrm_RelContasAPagar = class(TForm)
    AgrupaEntidade: TRLGroup;
    bdCabEntidade: TRLBand;
    bdDetalheAPagar: TRLBand;
    bdDetalhePagas: TRLBand;
    bdRodapeAPagar: TRLBand;
    bdRodapePagas: TRLBand;
    bdSumarioAPagar: TRLBand;
    bdSumarioPagas: TRLBand;
    Relatorio: TRLReport;
    RLBand1: TRLBand;
    RLDBText1: TRLDBText;
    RLDBText10: TRLDBText;
    RLDBText2: TRLDBText;
    RLDBText3: TRLDBText;
    RLDBText4: TRLDBText;
    RLDBText5: TRLDBText;
    RLDBText6: TRLDBText;
    RLDBText8: TRLDBText;
    RLDBText9: TRLDBText;
    RLDraw1: TRLDraw;
    RLDraw2: TRLDraw;
    RLDraw3: TRLDraw;
    RLDraw4: TRLDraw;
    RLDraw5: TRLDraw;
    RLLabel1: TRLLabel;
    RLLabel10: TRLLabel;
    RLLabel11: TRLLabel;
    RLLabel12: TRLLabel;
    RLLabel13: TRLLabel;
    RLLabel14: TRLLabel;
    RLLabel2: TRLLabel;
    RLLabel3: TRLLabel;
    RLLabel4: TRLLabel;
    RLLabel5: TRLLabel;
    RLLabel6: TRLLabel;
    RLLabel7: TRLLabel;
    RLLabel8: TRLLabel;
    RLLabel9: TRLLabel;
    rlPeriodo: TRLLabel;
    rlAPagarAgrupado: TRLLabel;
    rlAPagarTotal: TRLLabel;
    rlPagasAgrupado: TRLLabel;
    rlPagasTotal: TRLLabel;
    rlTitulo: TRLLabel;
    Rodape: TRLBand;
    procedure AgrupaEntidadeBeforePrint(Sender: TObject; var PrintIt: Boolean);
    procedure bdDetalheAPagarBeforePrint(Sender: TObject; var PrintIt: Boolean);
    procedure bdDetalhePagasBeforePrint(Sender: TObject; var PrintIt: Boolean);
    procedure bdRodapeAPagarBeforePrint(Sender: TObject; var PrintIt: Boolean);
    procedure bdRodapePagasBeforePrint(Sender: TObject; var PrintIt: Boolean);
    procedure bdSumarioAPagarBeforePrint(Sender: TObject; var PrintIt: Boolean);
    procedure bdSumarioPagasBeforePrint(Sender: TObject; var PrintIt: Boolean);
    procedure RelatorioBeforePrint(Sender: TObject; var PrintIt: Boolean);
  private
    FAgrupadoAPagar : Currency;
    FAgrupadoPagas : Currency;
    FTotalAPagar : Currency;
    FTotalPagas : Currency;
  public

  end;

var
  frm_RelContasAPagar: Tfrm_RelContasAPagar;

implementation

{$R *.lfm}

{ Tfrm_RelContasAPagar }

procedure Tfrm_RelContasAPagar.RelatorioBeforePrint(Sender: TObject;
  var PrintIt: Boolean);
begin
  FTotalAPagar:=0;
  FTotalPagas:=0;
end;

procedure Tfrm_RelContasAPagar.AgrupaEntidadeBeforePrint(Sender: TObject;
  var PrintIt: Boolean);
begin
  FAgrupadoAPagar:=0;
  FAgrupadoPagas:=0;

end;

procedure Tfrm_RelContasAPagar.bdDetalheAPagarBeforePrint(Sender: TObject;
  var PrintIt: Boolean);
begin
  FAgrupadoAPagar := FAgrupadoAPagar +
  TDataSet(RLReport1.DataSource.DataSet).FieldByName('valor').AsFloat;

  FTotalAPagar := FTotalAPagar +
  TDataSet(RLReport1.DataSource.DataSet).FieldByName('valor').AsFloat;

end;

procedure Tfrm_RelContasAPagar.bdDetalhePagasBeforePrint(Sender: TObject;
  var PrintIt: Boolean);
begin
  PrintIt := TDataSet(RLReport1.DataSource.DataSet).
          FieldByName('situacao').AsString = 'B';

  FAgrupadoPagas := FAgrupadoPagas +
  TDataSet(RLReport1.DataSource.DataSet).FieldByName('valorpago').AsFloat;

  FTotalPagas := FTotalPagas +
  TDataSet(RLReport1.DataSource.DataSet).FieldByName('valorpago').AsFloat;

end;

procedure Tfrm_RelContasAPagar.bdRodapeAPagarBeforePrint(Sender: TObject;
  var PrintIt: Boolean);
begin
  rlAPagarAgrupado.Caption:= FormatFloat('###,##0.00',FAgrupadoAPagar);

end;

procedure Tfrm_RelContasAPagar.bdRodapePagasBeforePrint(Sender: TObject;
  var PrintIt: Boolean);
begin
  PrintIt := TDataSet(RLReport1.DataSource.DataSet).
          FieldByName('situacao').AsString = 'B';

  rlRecebidoAgrupado.Caption:= FormatFloat('###,##0.00',FAgrupadoPagas);

end;

procedure Tfrm_RelContasAPagar.bdSumarioAPagarBeforePrint(Sender: TObject;
  var PrintIt: Boolean);
begin
  rlAPagarTotal.Caption:= FormatFloat('###,##0.00',FTotalAPagar);

end;

procedure Tfrm_RelContasAPagar.bdSumarioPagasBeforePrint(Sender: TObject;
  var PrintIt: Boolean);
begin
  PrintIt := TDataSet(RLReport1.DataSource.DataSet).
          FieldByName('situacao').AsString = 'B';


  rlPagasTotal.Caption:= FormatFloat('###,##0.00',FTotalPagas);

end;

end.

