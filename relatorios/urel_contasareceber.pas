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
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, RLReport;

type

  { Tfrm_RelContasARceber }

  Tfrm_RelContasARceber = class(TForm)
    Cabecalho: TRLBand;
    lbTitulo: TRLLabel;
    AgrupaEntidade: TRLGroup;
    BandCabEntidade: TRLBand;
    BandDetalhes: TRLBand;
    BandRodapeEntidade: TRLBand;
    RLLabel8: TRLLabel;
    lbPeriodo: TRLLabel;
    Rodape: TRLBand;
    RLBand3: TRLBand;
    RLDBResult1: TRLDBResult;
    RLDBResult2: TRLDBResult;
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
    procedure RLLabel2AfterPrint(Sender: TObject);
  private

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

end.

