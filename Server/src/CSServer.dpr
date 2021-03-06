program CSServer;
{$APPTYPE GUI}

uses
  Vcl.Forms,
  Web.WebReq,
  IdHTTPWebBrokerBridge,
  uDashBoard in 'uDashBoard.pas' {DashBoard},
  uService in 'classes\uService.pas',
  uWebModule in 'uWebModule.pas' {WebMod: TWebModule},
  uCliente in 'classes\uCliente.pas',
  HKConst_Alfabeto in '..\..\core\HKConst_Alfabeto.pas',
  HKCripto in '..\..\core\HKCripto.pas',
  uUtils in 'utils\uUtils.pas',
  udmConexao in 'db\udmConexao.pas' {dmConexao: TDataModule},
  uUsuario in 'classes\uUsuario.pas',
  uVenda in 'classes\uVenda.pas',
  uRecords in 'utils\uRecords.pas',
  uEmail in 'utils\uEmail.pas',
  uEstabelecimento in 'classes\uEstabelecimento.pas',
  uSegmento in 'classes\uSegmento.pas';

{$R *.res}

begin
  if WebRequestHandler <> nil then
    WebRequestHandler.WebModuleClass := WebModuleClass;
  Application.Initialize;
  Application.CreateForm(TdmConexao, dmConexao);
  Application.CreateForm(TDashBoard, DashBoard);
  Application.Run;
end.
