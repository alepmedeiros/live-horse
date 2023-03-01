unit Unit1;

interface

uses
  System.SysUtils,
  System.Types,
  System.UITypes,
  System.Classes,
  System.Variants,
  FMX.Types,
  FMX.Controls,
  FMX.Forms,
  FMX.Graphics,
  FMX.Dialogs,
  FMX.Objects,
  FMX.Layouts,
  FMX.Controls.Presentation,
  FMX.StdCtrls,
  utils,
  FireDAC.Stan.Intf,
  FireDAC.Stan.Option,
  FireDAC.Stan.Param,
  FireDAC.Stan.Error,
  FireDAC.DatS,
  FireDAC.Phys.Intf,
  FireDAC.DApt.Intf,
  Data.DB,
  FireDAC.Comp.DataSet,
  FireDAC.Comp.Client,
  serviceinterfaces,
  service,
  System.json,
  DataSet.Serialize,
  Datasnap.DBClient,
  Unit2,
  Unit3,
  FMX.Edit;

type
  TForm1 = class(TForm)
    Layout1: TLayout;
    Layout2: TLayout;
    Rectangle1: TRectangle;
    Layout3: TLayout;
    Rectangle2: TRectangle;
    Rectangle3: TRectangle;
    VertScrollBox1: TVertScrollBox;
    Layout4: TLayout;
    Layout5: TLayout;
    Layout6: TLayout;
    Layout7: TLayout;
    Layout8: TLayout;
    Layout9: TLayout;
    Layout10: TLayout;
    Rectangle4: TRectangle;
    Rectangle5: TRectangle;
    Rectangle6: TRectangle;
    Rectangle7: TRectangle;
    Image1: TImage;
    Image2: TImage;
    Image3: TImage;
    Image4: TImage;
    btnuser: TSpeedButton;
    btnCustomers: TSpeedButton;
    btnalgo: TSpeedButton;
    btnAlgo2: TSpeedButton;
    Layout11: TLayout;
    Layout12: TLayout;
    Layout13: TLayout;
    Label1: TLabel;
    Rectangle8: TRectangle;
    Label2: TLabel;
    Layout14: TLayout;
    Layout15: TLayout;
    Layout16: TLayout;
    Label3: TLabel;
    edtLimit: TEdit;
    Label4: TLabel;
    edtPage: TEdit;
    Layout17: TLayout;
    lblPage: TLabel;
    lblTotalPages: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure btnCustomersClick(Sender: TObject);
    procedure btnalgoClick(Sender: TObject);
    procedure btnAlgo2Click(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnuserClick(Sender: TObject);
  private
    FService: iService;
    FEtag: String;
    FUsers: TFDMemtable;
    FCustomers: TFDMemtable;
    FCache: TFDMemtable;
    FCode: Integer;

    LJSONValue: TJSONValue;
    LDados: TJSONArray;

    procedure BuscaUsuario;
    procedure BuscaCliente;
    procedure LimparVertScrollBox;
    function VerificaEtag: boolean;
    procedure PreparaUsers;
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.fmx}

procedure TForm1.btnAlgo2Click(Sender: TObject);
begin
  ShowMessage('Horse na veia');
end;

procedure TForm1.btnalgoClick(Sender: TObject);
begin
  try
    FService.Body('{"name": "' + edtLimit.Text + '"}').ToCreate('/customers');
    ShowMessage('Cliente cadastrado');
  except
    raise Exception.Create('Erro ao cadastrar cliente');
  end;
end;

procedure TForm1.btnCustomersClick(Sender: TObject);
begin
  BuscaCliente;
end;

procedure TForm1.btnuserClick(Sender: TObject);
begin
  BuscaUsuario;
end;

procedure TForm1.BuscaCliente;
var
  lFrame: TFrameCustomers;
  item: Integer;
begin
  if not VerificaEtag then
  begin
    VertScrollBox1.BeginUpdate;
    try
      LimparVertScrollBox;

      FCustomers.First;
      while not FCustomers.Eof do
      begin
        lFrame := TFrameCustomers.Create(VertScrollBox1);
        lFrame.Name := lFrame.ClassName + item.ToString;
        lFrame.Parent := VertScrollBox1;
        lFrame.Align := TAlignLayout.Top;
        lFrame.lblNome.Text := FCustomers.FieldByName('name').AsString;
        lFrame.lblCodigo.Text := FCustomers.FieldByName('guuid').AsString;
        inc(item);
        FCustomers.Next;
      end;

    finally
      VertScrollBox1.EndUpdate;
    end;
  end;
end;

procedure TForm1.LimparVertScrollBox;
var
  I: Integer;
begin
  for I := Pred(VertScrollBox1.Content.ControlsCount) downto 0 do
    VertScrollBox1.Content.Controls[I].DisposeOf;
end;

function TForm1.VerificaEtag: boolean;
var
  lCode: Integer;
begin
  try
    lCode := TService.New.Headers('If-None-Match', FEtag)
      .ListarTodos('/customers').StatusCode;
  except

  end;

  if lCode = 304 then
    result := False
  else
  begin
    TService.New.DataSet(FCustomers).ListarTodos('/customers').ETag(FEtag);
    result := False;
  end;
end;

procedure TForm1.PreparaUsers;
var
  lContent: string;
begin
  FService
    .Headers('X-Paginate', 'true')
    .ListarTodos(Format('/users?limit=%s&page=%s', [edtLimit.Text, edtPage.Text])).Content(lContent);
  LJSONValue := TJSONObject.ParseJSONValue(lContent) as TJSONValue;
  LDados := LJSONValue.GetValue<TJSONArray>('docs');
end;

procedure TForm1.BuscaUsuario;
var
  lFrame: TFrameUsers;
  item: Integer;
begin
  PreparaUsers;

  lblPage.Text := 'Page = ' + LJSONValue.GetValue<String>('page');
  lblTotalPages.Text := 'Total Pages = ' + LJSONValue.GetValue<String>('pages');

  if not FUsers.IsEmpty then
    FUsers.EmptyDataSet;

  FUsers.LoadFromJSON(LDados);

  VertScrollBox1.BeginUpdate;
  try
    LimparVertScrollBox;

    FUsers.First;
    while not FUsers.Eof do
    begin
      lFrame := TFrameUsers.Create(VertScrollBox1);
      lFrame.Name := lFrame.ClassName + item.ToString;
      lFrame.Parent := VertScrollBox1;
      lFrame.Align := TAlignLayout.Top;
      lFrame.lblNome.Text := FUsers.FieldByName('name').AsString;
      lFrame.lblTelefone.Text := FUsers.FieldByName('phone').AsString;
      inc(item);
      FUsers.Next;
    end;

  finally
    VertScrollBox1.EndUpdate;
  end;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  FService := TService.New;
  FUsers := TFDMemtable.Create(nil);
  FCustomers := TFDMemtable.Create(nil);
  FCache := TFDMemtable.Create(nil);

  TUtils.ResourceImage('img_user', Image1);
  TUtils.ResourceImage('img_customer', Image2);
  TUtils.ResourceImage('img_card', Image3);
  TUtils.ResourceImage('img_horse', Image4);
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  FUsers.Free;
  FCustomers.Free;
  FCache.Free;
end;

end.


// implementacoes de teste
// if not FEtag.IsEmpty then
// begin
// if not (FService.ListarTodos('/customers').Headers('If-None-Match', FEtag).StatusCode = 304) then
// FCustomers := FCache
// else
// FService.DataSet(FCustomers).ListarTodos('/customers').ETag(FEtag);
// end
// else
// begin
// FService.DataSet(FCustomers).ListarTodos('/customers').ETag(FEtag);
// FCache := FCustomers;
// end;

// if FEtag.IsEmpty then
// begin
// TService.New.DataSet(FCustomers).ListarTodos('/customers').ETag(FEtag);
// Result := False;
// end;
