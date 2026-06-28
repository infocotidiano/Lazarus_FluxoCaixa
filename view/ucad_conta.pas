unit ucad_conta;
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
  ACBrEnterTab, ZDataset, DB, ucad_padrao, classe_conta;

type

  { Tfrmcad_conta }

  Tfrmcad_conta = class(Tfrmcad_padrao)
    ACBrEnterTab1: TACBrEnterTab;
    DBGrid1: TDBGrid;
    dsPESQ: TDataSource;
    edtAGENCIA: TEdit;
    edtBANCO: TEdit;
    edtCODIGO: TEdit;
    edtCONTA: TEdit;
    edtDESCRICAO: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    qrPESQ: TZQuery;
    qrPESQagencia: TStringField;
    qrPESQbanco: TStringField;
    qrPESQconta: TStringField;
    qrPESQdescricao: TStringField;
    qrPESQid_conta: TLongintField;
    procedure btnALTERAClick(Sender: TObject);
    procedure btnAPAGAClick(Sender: TObject);
    procedure btnPESQUISAClick(Sender: TObject);
    procedure btnSALVAClick(Sender: TObject);
    procedure DBGrid1DblClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    procedure  PesquisarContas;
  public

  end;

var
  frmcad_conta: Tfrmcad_conta;
  conta: Tconta;

implementation
 uses uquery_helper, uapp_validacoes;

{$R *.lfm}

{ Tfrmcad_conta }

procedure Tfrmcad_conta.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  if Assigned(conta) then
    FreeAndNil(conta);

end;

procedure Tfrmcad_conta.btnPESQUISAClick(Sender: TObject);
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

procedure Tfrmcad_conta.btnSALVAClick(Sender: TObject);
begin
  inherited;
  conta.id_conta := StrToIntDef(edtCODIGO.Text, 0);
  conta.descricao := edtDESCRICAO.Text;
  conta.banco := edtBANCO.Text;
  conta.agencia := edtAGENCIA.Text;
  conta.conta := edtCONTA.Text;
  if cliqueBotao = cbAlterar then
    conta.altera(conta.id_conta)
  else if cliqueBotao = cbIncluir then
      conta.incluir;
  cliqueBotao := cbNone;
  qrPESQ.Refresh;
  PageControl1.PageIndex := 0;

end;

procedure Tfrmcad_conta.btnALTERAClick(Sender: TObject);
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

procedure Tfrmcad_conta.btnAPAGAClick(Sender: TObject);
begin
  if strtointdef(edtCODIGO.Text, 0) = 0 then
  begin
    ShowMessage('nenhum registro selecionado');
    cliqueBotao := cbNone;
    Abort;
  end;
  if QuestionDlg('Confirmação', 'Excluir o registro', mtConfirmation,
    [mrYes, 'Sim', mrNo, 'Não'], 0) = mrYes then
    conta.exclui(conta.id_conta);
  inherited;

  qrPESQ.Refresh;

  PageControl1.PageIndex := 0;
  cliqueBotao := cbNone;

end;

procedure Tfrmcad_conta.DBGrid1DblClick(Sender: TObject);
begin
  if conta.localiza(qrPESQid_conta.Value) then
  begin
    PageControl1.PageIndex := 1;
    edtCODIGO.Text := IntToStr(conta.id_conta);
    edtDESCRICAO.Text := conta.descricao;
    edtBANCO.Text := conta.banco;
    edtAGENCIA.Text := conta.agencia;
    edtCONTA.Text := conta.conta;
  end;

end;

procedure Tfrmcad_conta.FormCreate(Sender: TObject);
begin
  conta := Tconta.Create;
end;

procedure Tfrmcad_conta.FormShow(Sender: TObject);
begin
  inherited;
  if not qrPESQ.Active then
    qrPESQ.Open;
end;

procedure Tfrmcad_conta.PesquisarContas;
begin
  TQueryHelper.AbrirPesquisaLike(qrPESQ, 'contas', 'descricao', edtPESQUISA.Text);
end;

end.
