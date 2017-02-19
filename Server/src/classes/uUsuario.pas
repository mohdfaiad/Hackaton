unit uUsuario;

interface

uses
  FireDAC.Comp.Client, System.SysUtils, uCliente;

type
  TUsuario = class(TCliente)
  private
    FDataNascimento: TDateTime;
    FCPF: string;
    FSexo: string;
    FSenha: string;

    FConfigEmail: string;
    FConfigSenha: string;
    FConfigPorta: Integer;
    FConfigHost: string;
    FConfigAssunto: string;

    procedure EnviaEmail;
    procedure CarregaConfigEmail;
    { Private Declarations }
  public
    //M�todos p�blicos
    procedure CadastraUsuario;
    procedure LocalizaUsuarioPorEmail(AEmail: string);

    //Propriedades
    property CPF           : string     read FCPF             write FCPF;
    property Sexo          : string     read FSexo            write FSexo;
    property DataNascimento: TDateTime  read FDataNascimento  write FDataNascimento;
    property Senha         : string     read FSenha           write FSenha;
    { Public Declarations }
  end;

implementation

uses
  uEmail;

{ TUsuario }

procedure TUsuario.CadastraUsuario;
var
  LQuery : TFDQuery;
begin
  //M�todo para cadastrar o cliente
  CadastraCliente;

  LQuery := TFDQuery.Create(FConexao);
  try
    try
      LQuery.Connection := FConexao;

      LQuery.SQL.Clear;
      LQuery.SQL.Add('insert into usuario (');
      LQuery.SQL.Add('  id      ');
      LQuery.SQL.Add(') values (');
      LQuery.SQL.Add('  :id     ');
      LQuery.SQL.Add(')');

      LQuery.ParamByName('id').AsInteger := FId;
      LQuery.ExecSQL();
    except
      raise Exception.Create('ERRO AO GRAVAR USUARIO');
    end;
  finally
    FreeAndNil(LQuery);
  end;
end;

procedure TUsuario.CarregaConfigEmail;
var
  LQuery : TFDQuery;
begin
  LQuery := TFDQuery.Create(FConexao);
  try
    try
      LQuery.Connection := FConexao;

      LQuery.SQL.Clear;
      LQuery.SQL.Add('SELECT         ');
      LQuery.SQL.Add('  email,       ');
      LQuery.SQL.Add('  senha,       ');
      LQuery.SQL.Add('  host,        ');
      LQuery.SQL.Add('  porta,       ');
      LQuery.SQL.Add('  assunto      ');
      LQuery.SQL.Add('FROM           ');
      LQuery.SQL.Add('  email_config ');
      LQuery.Open();

      //N�o existe registro
      if LQuery.RecordCount <> 0 then
      begin
        FConfigEmail   := LQuery.FieldByName('email').AsString;
        FConfigSenha   := LQuery.FieldByName('senha').AsString;
        FConfigPorta   := LQuery.FieldByName('porta').AsInteger;
        FConfigHost    := LQuery.FieldByName('host').AsString;
        FConfigAssunto := LQuery.FieldByName('assunto').AsString;
      end;
    except
      raise Exception.Create('ERRO AO GRAVAR USUARIO');
    end;
  finally
    FreeAndNil(LQuery);
  end;
end;

procedure TUsuario.EnviaEmail;
var
  LEmail: TEmail;
begin
  CarregaConfigEmail;

  LEmail := TEmail.Create(FConfigEmail, FEMail, FConfigSenha, FConfigHost, FConfigAssunto, FConfigPorta);
  try
    LEmail.EnviarEmail;
  finally
    FreeAndNil(LEmail);
  end;
end;

procedure TUsuario.LocalizaUsuarioPorEmail(AEmail: string);
var
  LQuery : TFDQuery;
  LEmail: TEmail;
begin
  LQuery := TFDQuery.Create(FConexao);
  try
    try
      LQuery.Connection := FConexao;

      LQuery.SQL.Clear;
      LQuery.SQL.Add('SELECT               ');
      LQuery.SQL.Add('  c.id,              ');
      LQuery.SQL.Add('  c.nome,            ');
      LQuery.SQL.Add('  c.email,           ');
      LQuery.SQL.Add('  c.endereco,        ');
      LQuery.SQL.Add('  c.complemento,     ');
      LQuery.SQL.Add('  c.numero,          ');
      LQuery.SQL.Add('  c.bairro,          ');
      LQuery.SQL.Add('  c.Cep,             ');
      LQuery.SQL.Add('  u.Cpf,             ');
      LQuery.SQL.Add('  u.Data_Nascimento, ');
      LQuery.SQL.Add('  u.Sexo,            ');
      LQuery.SQL.Add('  u.Senha            ');
      LQuery.SQL.Add('FROM                 ');
      LQuery.SQL.Add('  usuario u          ');
      LQuery.SQL.Add('  INNER JOIN cliente c ON (u.id = c.id) ');
      LQuery.SQL.Add('WHERE                ');
      LQuery.SQL.Add('  email = :email     ');

      LQuery.ParamByName('email').AsString := AEmail;
      LQuery.Open();

      FEMail := AEmail;

      //N�o existe registro
      if LQuery.RecordCount = 0 then
      begin
        CadastraUsuario;
        EnviaEmail;
      end
      else
      begin
        FId             := LQuery.FieldByName('id').AsInteger;
        FNome           := LQuery.FieldByName('nome').AsString;
        FEMail          := LQuery.FieldByName('email').AsString;
        FEndereco       := LQuery.FieldByName('endereco').AsString;
        FComplemento    := LQuery.FieldByName('complemento').AsString;
        FNumero         := LQuery.FieldByName('numero').AsString;
        FBairro         := LQuery.FieldByName('bairro').AsString;
        FCEP            := LQuery.FieldByName('Cep').AsString;
        FCPF            := LQuery.FieldByName('Cpf').AsString;
        FSexo           := LQuery.FieldByName('Sexo').AsString;
        FDataNascimento := LQuery.FieldByName('Data_Nascimento').AsDateTime;
        FSenha          := LQuery.FieldByName('Senha').AsString;
      end;
    except
      raise Exception.Create('ERRO AO GRAVAR USUARIO');
    end;
  finally
    FreeAndNil(LQuery);
  end;
end;

end.
