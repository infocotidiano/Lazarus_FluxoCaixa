unit urel_contasareceber;
{***************************************************************************}
{   Autor:        Daniel de Morais (InfoCotidiano)                          }
{   Fontes:       Fluxo Caixa - https://github.com/infocotidiano/FluxoCaixa }
{                                                                           }
{   Informações:  Código Fonte da Playlist do YouTube sobre aprendizagem    }
{                 de como criar um Fluxo de Caixa.                          }
{                                                                           }
{   Aviso Legal:  Este código é fornecido exclusivamente para fins de       }
{                 estudo e aprendizagem. Não há qualquer garantia,          }
{                 explícita ou implícita, de funcionamento, adequação       }
{                 ou ausência de erros.                                     }

{                 O autor não se responsabiliza por danos diretos,          }
{                 indiretos, incidentais ou consequenciais decorrentes      }
{                 do uso deste código em ambientes de produção.             }
{                                                                           }
{                 Ao utilizar este código, você concorda que qualquer       }
{                 modificação, adaptação ou uso será de sua inteira         }
{                 responsabilidade.                                         }
{***************************************************************************}

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, RLReport, db;

type

  { Tfrm_RelContasARceber }

  Tfrm_RelContasARceber = class(TForm)
    bdDetalheRecebida: TRLBand;
    bdRodapeRecebida: TRLBand;
    bdSumarioRecebido: TRLBand;
    Cabecalho: TRLBand;
    lbTitulo: TRLLabel;
    AgrupaEntidade: TRLGroup;
    bdCabEntidade: TRLBand;
    bdDetalheReceber: TRLBand;
    bdRodapeReceber: TRLBand;
    RLDBText10: TRLDBText;
    RLDBText6: TRLDBText;
    RLDBText8: TRLDBText;
    RLDBText9: TRLDBText;
    RLDraw3: TRLDraw;
    RLDraw4: TRLDraw;
    RLDraw5: TRLDraw;
    RLLabel10: TRLLabel;
    RLLabel11: TRLLabel;
    RLLabel12: TRLLabel;
    RLLabel13: TRLLabel;
    RLLabel14: TRLLabel;
    rlReceberAgrupado: TRLLabel;
    RLLabel8: TRLLabel;
    lbPeriodo: TRLLabel;
    RLLabel9: TRLLabel;
    rlRecebidoAgrupado: TRLLabel;
    rlReceberTotal: TRLLabel;
    rlRecebidoTotal: TRLLabel;
    Rodape: TRLBand;
    bdSumarioReceber: TRLBand;
    RLDBText1: TRLDBText;
    RLDBText2: TRLDBText;
    RLDBText3: TRLDBText;
    RLDBText4: TRLDBText;
    RLDBText5: TRLDBText;
    RLDraw1: TRLDraw;
    RLDraw2: TRLDraw;
    RLLabel1: TRLLabel;
    RLLabel2: TRLLabel;
    RLLabel3: TRLLabel;
    RLLabel4: TRLLabel;
    RLLabel5: TRLLabel;
    RLLabel6: TRLLabel;
    RLLabel7: TRLLabel;
    RLReport1: TRLReport;
    procedure AgrupaEntidadeBeforePrint(Sender: TObject; var PrintIt: Boolean);
    procedure bdDetalheReceberBeforePrint(Sender: TObject; var PrintIt: Boolean
      );
    procedure bdDetalheRecebidaBeforePrint(Sender: TObject; var PrintIt: Boolean
      );
    procedure bdRodapeReceberBeforePrint(Sender: TObject; var PrintIt: Boolean);
    procedure bdRodapeRecebidaBeforePrint(Sender: TObject; var PrintIt: Boolean
      );
    procedure bdSumarioReceberBeforePrint(Sender: TObject; var PrintIt: Boolean
      );
    procedure bdSumarioRecebidoBeforePrint(Sender: TObject; var PrintIt: Boolean
      );
    procedure RLLabel2AfterPrint(Sender: TObject);
    procedure RLReport1BeforePrint(Sender: TObject; var PrintIt: Boolean);
  private
    FAgrupadoReceber : Currency;
    FAgrupadoRecebido : Currency;
    FTotalRecebido : Currency;
    FTotalReceber : Currency;

  public

  end;

var
  frm_RelContasARceber: Tfrm_RelContasARceber;

implementation

{$R *.lfm}

{ Tfrm_RelContasARceber }

procedure Tfrm_RelContasARceber.RLLabel2AfterPrint(Sender: TObject);
begin

end;

procedure Tfrm_RelContasARceber.AgrupaEntidadeBeforePrint(Sender: TObject;
  var PrintIt: Boolean);
begin
  FAgrupadoReceber:=0;
  FAgrupadoRecebido:=0;
end;

procedure Tfrm_RelContasARceber.bdDetalheReceberBeforePrint(Sender: TObject;
  var PrintIt: Boolean);
begin
  FAgrupadoReceber := FAgrupadoReceber +
  TDataSet(RLReport1.DataSource.DataSet).FieldByName('valor').AsFloat;

  FTotalReceber := FTotalReceber +
  TDataSet(RLReport1.DataSource.DataSet).FieldByName('valor').AsFloat;
end;

procedure Tfrm_RelContasARceber.bdDetalheRecebidaBeforePrint(Sender: TObject;
  var PrintIt: Boolean);
begin

  PrintIt := TDataSet(RLReport1.DataSource.DataSet).
          FieldByName('situacao').AsString = 'B';

  FAgrupadoRecebido := FAgrupadoRecebido +
  TDataSet(RLReport1.DataSource.DataSet).FieldByName('valorrecebido').AsFloat;

  FTotalRecebido := FTotalRecebido +
  TDataSet(RLReport1.DataSource.DataSet).FieldByName('valorrecebido').AsFloat;
end;

procedure Tfrm_RelContasARceber.bdRodapeReceberBeforePrint(Sender: TObject;
  var PrintIt: Boolean);
begin
  rlReceberAgrupado.Caption:= FormatFloat('###,##0.00',FAgrupadoReceber);
end;

procedure Tfrm_RelContasARceber.bdRodapeRecebidaBeforePrint(Sender: TObject;
  var PrintIt: Boolean);
begin
  PrintIt := TDataSet(RLReport1.DataSource.DataSet).
          FieldByName('situacao').AsString = 'B';

  rlRecebidoAgrupado.Caption:= FormatFloat('###,##0.00',FAgrupadoRecebido);

end;

procedure Tfrm_RelContasARceber.bdSumarioReceberBeforePrint(Sender: TObject;
  var PrintIt: Boolean);
begin
  rlReceberTotal.Caption:= FormatFloat('###,##0.00',FTotalReceber);

end;

procedure Tfrm_RelContasARceber.bdSumarioRecebidoBeforePrint(Sender: TObject;
  var PrintIt: Boolean);
begin
  PrintIt := TDataSet(RLReport1.DataSource.DataSet).
          FieldByName('situacao').AsString = 'B';


  rlRecebidoTotal.Caption:= FormatFloat('###,##0.00',FTotalRecebido);

end;

procedure Tfrm_RelContasARceber.RLReport1BeforePrint(Sender: TObject;
  var PrintIt: Boolean);
begin
  FTotalReceber:=0;
  FTotalRecebido:=0;
end;

end.

