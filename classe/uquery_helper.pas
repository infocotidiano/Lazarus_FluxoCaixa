unit uquery_helper;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, ZDataset;

type
  {TQueryHelper}
  TQueryHelper = class
  public
    // preparar a query para receber uma intrução sql.
    class procedure Preparar(AQuery : TZQuery);
    // abre query padrodizando a mensagem de erro.
    class procedure Abrir(AQuery: TZQuery; AMensagemErro:String);
    // Pesquisa simples por like
    class procedure AbrirPesquisaLike(AQuery: TZQuery;
      const ATabela, ACampoFiltro, ATextoFiltro: String);
  end;

implementation

{ TQueryHelper }

class procedure TQueryHelper.Preparar(AQuery: TZQuery);
begin
  if AQuery.Active then
     AQuery.Close;
  AQuery.SQL.Clear;
end;

class procedure TQueryHelper.Abrir(AQuery: TZQuery; AMensagemErro: String);
begin
  try
   AQuery.Open;
  except
    on e: Exception do
       raise Exception.Create(AMensagemErro + sLineBreak +
             e.ClassName + sLineBreak + e.Message);
  end;
end;

class procedure TQueryHelper.AbrirPesquisaLike(AQuery: TZQuery;
      const ATabela, ACampoFiltro, ATextoFiltro: String);
begin
  Preparar(AQuery);

  AQuery.sql.Add('select * from ' + ATabela);
  AQuery.sql.add('where '+ACampoFiltro+' like :cPESQ');
  AQuery.ParamByName('cPESQ').AsString := '%' + trim(ATextoFiltro + '%');

  Abrir(AQuery, 'Erro ao realizar a pesquisa');
end;

end.

