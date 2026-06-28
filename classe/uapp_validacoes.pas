unit uapp_validacoes;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils;
type
  {AppValidacoes}

  { TAppValidacoes }

  TAppValidacoes = class
  public
    // converte texto para inteiro.
    class function TextoParaInteiro(Const ATexto: String;
          ADefault: Integer = 0): Integer;
    // valida se existe registro selecionado.
    class procedure RegistroSelecionado(ACodigo: Integer);
    // valida periodo de datas
    class procedure PeriodoValido(ADataInicio, ADataFinal: TDate);
  end;

implementation

{ TAppValidacoes }

class function TAppValidacoes.TextoParaInteiro(const ATexto: String;
  ADefault: Integer): Integer;
begin
  Result := strtointdef(trim(ATexto), ADefault);
end;

class procedure TAppValidacoes.RegistroSelecionado(ACodigo: Integer);
begin
  if ACodigo <= 0 then
     raise Exception.create('Nenhum registro selecionado.');

end;

class procedure TAppValidacoes.PeriodoValido(ADataInicio, ADataFinal: TDate);
begin
 if ADataInicio > ADataFinal then
    raise Exception.create('A data inicial não pode ser maior que a data final');
end;

end.

