unit ucad_planoconta;
{***************************************************************************}
{                                                                           }
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
{                                                                           }
{                 O autor não se responsabiliza por danos diretos,          }
{                 indiretos, incidentais ou consequenciais decorrentes      }
{                 do uso deste código em ambientes de produção.             }
{                                                                           }
{                 Ao utilizar este código, você concorda que qualquer       }
{                 modificação, adaptação ou uso será de sua inteira         }
{                 responsabilidade.                                         }
{                                                                           }
{***************************************************************************}


{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, DBGrids,
  ACBrEnterTab, ZDataset, DB, ucad_padrao, classe_plano;

type

  { Tfrmcad_planoconta }

  Tfrmcad_planoconta = class(Tfrmcad_padrao)
    ACBrEnterTab1: TACBrEnterTab;
    cmbTIPO: TComboBox;
    DBGrid1: TDBGrid;
    dsPESQ: TDataSource;
    edtCODIGO: TEdit;
    edtDESCRICAO: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    qrPESQ: TZQuery;
    qrPESQdescricao: TStringField;
    qrPESQid_plano: TLongintField;
    qrPESQtipo: TStringField;
    procedure btnALTERAClick(Sender: TObject);
    procedure btnAPAGAClick(Sender: TObject);
    procedure btnPESQUISAClick(Sender: TObject);
    procedure btnSALVAClick(Sender: TObject);
    procedure DBGrid1DblClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    procedure PesquisarContas;
  public

  end;

var
  frmcad_planoconta: Tfrmcad_planoconta;
  oPlano: Tplano;

implementation
  uses uquery_helper, uapp_validacoes;


{$R *.lfm}

{ Tfrmcad_planoconta }

procedure Tfrmcad_planoconta.FormCreate(Sender: TObject);
begin
  oPlano := TPlano.Create;
end;

procedure Tfrmcad_planoconta.FormShow(Sender: TObject);
begin
  inherited;
  if not qrPESQ.Active then
    qrPESQ.Open;

end;

procedure Tfrmcad_planoconta.PesquisarContas;
begin
  TQueryHelper.AbrirPesquisaLike(qrPESQ, 'planos', 'descricao', edtPESQUISA.Text);
end;

procedure Tfrmcad_planoconta.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  if Assigned(oPlano) then
    FreeAndNil(oPlano);

end;

procedure Tfrmcad_planoconta.DBGrid1DblClick(Sender: TObject);
begin
  if oPlano.localiza(qrPESQid_Plano.Value) then
  begin
    PageControl1.PageIndex := 1;
    edtCODIGO.Text := IntToStr(oPlano.id_plano);
    edtDESCRICAO.Text := oPlano.descricao;
    cmbTIPO.Text := oPlano.tipo;
  end;
end;

procedure Tfrmcad_planoconta.btnALTERAClick(Sender: TObject);
begin
  try
     TAppValidacoes.RegistroSelecionado(
           TAppValidacoes.TextoParaInteiro(edtCODIGO.Text));

     inherited;
     edtDESCRICAO.SetFocus;
  except
    on e: Exception do
       begin
         cliqueBotao := cbNone;
         ShowMessage(e.Message);
       end;
  end;

end;

procedure Tfrmcad_planoconta.btnAPAGAClick(Sender: TObject);
begin
  if strtointdef(edtCODIGO.Text, 0) = 0 then
  begin
    ShowMessage('nenhum registro selecionado');
    cliqueBotao := cbNone;
    Abort;
  end;

  if QuestionDlg('Confirmação', 'Excluir o registro', mtConfirmation,
    [mrYes, 'Sim', mrNo, 'Não'], 0) = mrYes then
    oPlano.exclui(oPlano.id_plano);
  inherited;
  cliqueBotao := cbNone;
  qrPESQ.Refresh;
  PageControl1.PageIndex := 0;
end;

procedure Tfrmcad_planoconta.btnPESQUISAClick(Sender: TObject);
begin
  try
    PesquisarContas;

    if qrPESQ.RecordCount <= 0 then
      ShowMessage('Nenhum registro encontrado !');
  Except
    on e: Exception do
       ShowMessage('e.Message');
  end;

  cliqueBotao := cbNone;

end;

procedure Tfrmcad_planoconta.btnSALVAClick(Sender: TObject);
begin
  inherited;
  oPlano.id_plano := StrToIntDef(edtCODIGO.Text, 0);
  oPlano.descricao := edtDESCRICAO.Text;
  oPlano.tipo := cmbTIPO.Text;
  if cliqueBotao = cbAlterar then
    oPlano.altera(oPlano.id_plano)
  else if cliqueBotao = cbIncluir then
    oPlano.incluir;
  cliqueBotao := cbNone;
  qrPESQ.Refresh;
  PageControl1.PageIndex := 0;

end;

end.
