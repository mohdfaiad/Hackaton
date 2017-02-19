unit uCliente;

interface

Uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FireDAC.Comp.Client, Data.DB, DBXJSON, System.JSON ;

type
  TCliente = class
  private
    function RetornaIdCliente: Integer;
    { Private Declarations }
  protected
    FConexao: TFDConnection;

    FId: Integer;
    FBairro: string;
    FEMail: string;
    FCEP: string;
    FNumero: string;
    FComplemento: string;
    FNome: string;
    FEndereco: string;

    procedure CadastraCliente;
    { Protected Declarations }
  public
    //M�todos p�blicos
    constructor Create(AConexao: TFDConnection); virtual;

    //Propriedades
    property Id         : Integer read FId           write FId;
    property Nome       : string  read FNome         write FNome;
    property EMail      : string  read FEMail        write FEMail;
    property Endereco   : string  read FEndereco     write FEndereco;
    property Complemento: string  read FComplemento  write FComplemento;
    property Numero     : string  read FNumero       write FNumero;
    property Bairro     : string  read FBairro       write FBairro;
    property CEP        : string  read FCEP          write FCEP;
    { Public Declarations }
  end;

implementation

{ TCliente }

procedure TCliente.CadastraCliente;
var
  LQuery : TFDQuery;
begin
  LQuery := TFDQuery.Create(FConexao);
  try
    try
      LQuery.Connection := FConexao;

      LQuery.SQL.Clear;
      LQuery.SQL.Add('insert into cliente (');
      LQuery.SQL.Add('  id      ,');
      LQuery.SQL.Add('  email    ');
      LQuery.SQL.Add(') values  (');
      LQuery.SQL.Add('  :id     ,');
      LQuery.SQL.Add('  :email   ');
      LQuery.SQL.Add(')');

      //Carrega ID do cliente
      FId := RetornaIdCliente();

      LQuery.ParamByName('id'   ).AsInteger := FId;
      LQuery.ParamByName('email').AsString  := FEMail;
      LQuery.ExecSQL();
    except
      raise Exception.Create('ERRO AO GRAVAR CLIENTE');
    end;
  finally
    FreeAndNil(LQuery);
  end;
end;

constructor TCliente.Create(AConexao: TFDConnection);
begin
  FConexao := AConexao;
end;

function TCliente.RetornaIdCliente: Integer;
var
  LQuery : TFDQuery;
begin
  Result := -1;

  LQuery := TFDQuery.Create(FConexao);
  try
    try
      LQuery.Connection := FConexao;
      LQuery.SQL.Clear;
      LQuery.SQL.Add('SELECT fn_cliente as valor FROM dual');
      LQuery.Open;

      Result := LQuery.FieldByName('valor').AsInteger;
    except
      raise Exception.Create('ERRO AO RETORNAR ID DO USUARIO');
    end;
  finally
    FreeAndNil(LQuery);
  end;
end;

end.
