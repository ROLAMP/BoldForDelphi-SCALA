unit BoldOTAFileHandler;

interface

uses
  Classes,
  Windows,
  ToolsAPI,
  BoldBase,
  BoldFileHandler,
  BoldDefs,
  BoldOTASupport;

type
  { forward declarations }
  TBoldIOTANotifier = class;
  TBoldIOTAEditorNotifier = class;
  TBoldOTAFileHandler = class;

  TBoldIOTANotifierState = (nsModifying, nsNormal);

  { TBoldOTAFileHandler }
  TBoldOTAFileHandler = class(TBoldFileHandler)
  private
    fModuleCreator: TBoldModuleCreator;
    fOTAEditReader: IOTAEditReader;
    fOTAEditWriter: IOTAEditWriter;
    FOTAModule: IOTAModule;
    FOTASourceEditor: IOTASourceEditor;
    fShowInEditor: Boolean;
    fWasOpen: Boolean;
    function GetEditorSize: Integer;
    function GetModuleCreator: TBoldModuleCreator;
    function GetOTAEditReader: IOTAEditReader;
    function GetOTAEditWriter: IOTAEditWriter;
    function GetOTAModule: IOTAModule;
    function GetOTASourceEditor: IOTASourceEditor;
    procedure SetEditorLine(Line: Integer);
  protected
    procedure LoadStringList; override;
    procedure DoFlushFile; override;
    procedure CloseFile; override;
  public
    constructor Create(const FileName: string; ModuleType: TBoldModuleType; ShowFileInGuiIfPossible: Boolean; OnInitializeFileContents: TBoldInitializeFileContents); override;
    destructor Destroy; override;
    function FileInProject(const name: string): Boolean;
    function FilePathInProject(const name: string): string;
    function PositionToTextInEditor(const S: string): Boolean;
    property ModuleCreator: TBoldModuleCreator read GetModuleCreator;
    property OTAEditReader: IOTAEditReader read GetOTAEditReader;
    property OTAEditWriter: IOTAEditWriter read GetOTAEditWriter;
    property OTAModule: IOTAModule read GetOTAModule;
    property OTASourceEditor: IOTASourceEditor read GetOTASourceEditor;
  end;

  { TBoldIOTANotifier }
  TBoldIOTANotifier = class(TBoldNonRefCountedObject, IOTANotifier)
  private
    fFileHandler: TBoldOTAFileHandler;
    fState: TBoldIOTANotifierState;
  public
    constructor create(fileHandler: TBoldOTAFileHandler);
    procedure AfterSave; virtual;
    procedure BeforeSave; virtual;
    procedure Destroyed; virtual;
    procedure Modified; virtual;
  end;

  { TBoldIOTAEditorNotifier }
  TBoldIOTAEditorNotifier = class(TBoldIOTANotifier, IOTAEditorNotifier)
    procedure ViewActivated(const View: IOTAEditView); virtual;
    procedure ViewNotification(const View: IOTAEditView; Operation: TOperation); virtual;
  end;

implementation

uses
  Dialogs,
  SysUtils,
  BoldUtils,
  BoldLogHandler,
  BoldCommonConst;

constructor TBoldOTAFileHandler.create(const FileName: string; ModuleType: TBoldModuleType; ShowFileInGuiIfPossible: Boolean; OnInitializeFileContents: TBoldInitializeFileContents);
begin
  // in OTA, strip away the path... we will find a new one later.
  OTADEBUGLogFmt(sLogCreatingOTAFileHandler, [FileName]);
  inherited Create(ExtractFileName(FileName), ModuleType, ShowFileInGuiIfPossible, OnInitializeFileContents);
  fModuleCreator := nil;
end;

function TBoldOTAFileHandler.FileInProject(const name: string): Boolean;
var
  Module: IOTAModule;
begin
  Module := FindFileModuleInProject(name, GetOTAProject);
  Result := assigned(Module);
end;

function TBoldOTAFileHandler.FilePathInProject(const name: string): string;
var
  module: IOTAModule;
begin
  Result := '';
  module := FindFileModuleInProject(Name, GetOTAProject);
  if assigned(Module) then
    result := Module.Getfilename;
end;

function TBoldOTAFileHandler.GetOTAModule: IOTAModule;
begin
  result := nil;
  if not assigned(fOTAModule) then
  begin
    fOtaModule := EnsuredModule(FileName, ModuleCreator, ModuleType = mttext, fWasOpen);
    if OTADEBUG then
    begin
      if fWasOpen then
        BoldLog.LogFmt(sLogModuleWasOpen, [FileName])
      else
        BoldLog.LogFmt(sLogHadToOpenModule, [FileName]);
    end;
//    OTADEBUGLogFmt('Done Creating OTAModule');
  end;

  result := fOTAModule;
end;

function TBoldOTAFileHandler.GetOTASourceEditor: IOTASourceEditor;
var
  i: integer;
  Editor: IOTAEditor;
begin
  if not Assigned(fOTASourceEditor) then
  begin
    for i := 0 to OTAModule.GetModuleFileCount - 1 do
    begin
      Editor := OTAModule.GetModuleFileEditor(i);
      if SameFileName(ExtractFileName(Editor.GetFileName), ExtractFileName(FileName)) and
        (Editor.QueryInterFace(IOTASourceEditor, fOTASourceEditor) = S_OK) then
        break;
    end;

    if not Assigned(fOTASourceEditor) then
      raise EBoldDesignTime.CreateFmt(sUnableToOpenSourceEditor, [filename]);
  end;

  Result := fOTASourceEditor;
end;

procedure TBoldOTAFileHandler.SetEditorLine(Line: Integer);
var
  EditPos: TOTAEditPos;
begin
  try
    with OTASourceEditor.GetEditView(0) do
    begin
      EditPos.Col := 0;
      EditPos.Line := Line;
      SetCursorPos(EditPos); // set cursorpos
      EditPos.Col := 1;
      SetTopPos(EditPos); // set viewpos
    end;
  except
    on E: Exception do
      Raise EBoldDesignTime.CreateFmt(sUnableToPositionCursor, [FileName, Line]);
  end;
end;

procedure TBoldOTAFileHandler.LoadStringList;
const
  ChunkSize = 30000;
var
  Buf: PChar;
  position: integer;
  s: String;
  Size,
  ReadChars: Integer;
begin
  Size := GetEditorSize;
  if Size > 0 then
  begin
    GetMem(Buf, Size + 1);
    try
      position := 0;
      while position < Size do
      begin
 //marco       ReadChars := OTAEditReader.GetText(position, buf + position, ChunkSize);  // bug, must be less that 2**31-1
        position := position + ReadChars;
      end;
      Buf[Size] := BoldNULL;
      SetLength(S, Size);
      S := string(Buf);

      StringList.Text := S;
    finally
      FreeMem(Buf, Size + 1);
    end;
  end
  else
  begin
    Stringlist.Clear;
  end;
//  OTADEBUGLogFmt('Adding to project');
// Doesn't work well!  (BorlandIDEServices as IOTAModuleServices).GetActiveProject.AddFile(FileName, true);
//  OTADEBUGLogFmt('DONE - Adding to project');
end;

function TBoldOTAFileHandler.PositionToTextInEditor(const S: string): Boolean;
var
  L: Integer;
begin
  Result := False;
  L := GetLineFromStringList(S);
  if L <> -1 then
  begin
    SetEditorLine(L + 1);
    Result := True;
  end;
end;

procedure TBoldOTAFileHandler.DoFlushFile;
begin
  if CheckWriteable(OTAModule.FileName) then
  begin
    OTAEditWriter.DeleteTo(GetEditorSize - 2);
//marco    OTAEditWriter.Insert(PChar(StringList.Text));
    OTAModule.Save(False, True);
  end
  else
  begin
    BoldLog.LogFmt(sModuleReadOnly, [OTAModule.FileName], ltError);
    ShowMessage(SysUtils.Format(sModuleReadOnly, [OTAModule.FileName]));
  end;
end;

function TBoldOTAFileHandler.GetModuleCreator: TBoldModuleCreator;
begin
  if not assigned(fModuleCreator) then
  begin
    fModuleCreator := TBoldModuleCreator.Create(FileName, ModuleType, fShowInEditor);
    if not FileInProject(Filename) then
      OTADEBUGLogFmt('File %s not in Project... ', [Filename]);
  end;

  result := fModuleCreator;
end;

function TBoldOTAFileHandler.GetEditorSize: Integer;
const
  ChunkSize = 30000;
var
  buf: array[0..ChunkSize] of Char;
  ReadChars: integer;
begin
  result := 0;
  repeat
//marco    ReadChars := OTAEditReader.GetText(Result, buf, ChunkSize);
    Result := Result + ReadChars;
  until ReadChars < ChunkSize;
end;

function TBoldOTAFileHandler.GetOTAEditReader: IOTAEditReader;
begin
  if Assigned(fOTAEditWriter) then
    fOTAEditWriter := nil;

  if not Assigned(fOTAEditReader) then
  try
    fOTAEditReader := OTASourceEditor.CreateReader;
  except
    on e: exception do
    begin
      BoldLog.LogFmt(sUnableToCreateReader, [e.message], ltError);
      raise
    end;
  end;
  result := fOTAEditReader;
end;

function TBoldOTAFileHandler.GetOTAEditWriter: IOTAEditWriter;
begin
  if Assigned(fOTAEditReader) then
    fOTAEditReader := nil;

  if not Assigned(fOTAEditWriter) then
    fOTAEditWriter := OTASourceEditor.CreateWriter;

  result := fOTAEditWriter;
end;

destructor TBoldOTAFileHandler.Destroy;
begin
  inherited; // Need to call inherited before freeing interfaces
  fOTAEditReader := nil;
  fOTAEditWriter := nil;
  fModuleCreator := nil;
end;

{ TBoldIOTANotifier }

procedure TBoldIOTANotifier.AfterSave;
begin
  // Nothing implemented here
end;

procedure TBoldIOTANotifier.BeforeSave;
begin
  // Nothing implemented here
end;

constructor TBoldIOTANotifier.create(fileHandler: TBoldOTAFileHandler);
begin
  fFilehandler := FileHandler;
  fState := nsNormal;
end;

procedure TBoldIOTANotifier.Destroyed;
begin
  // Nothing implemented here
end;

procedure TBoldIOTANotifier.Modified;
begin
{  if (fstate <> nsModifying) and fFileHandler.StringListModified then
    ShowMessage('Oops, a filehandler had a dirty StringList!');
}
{  if fstate <> nsModifying then
    FreeAndNil(fFileHandler.fStringList);
}
end;

{ TBoldIOTAEditorNotifier }

procedure TBoldIOTAEditorNotifier.ViewActivated(const View: IOTAEditView);
begin
  // Nothing implemented here
end;

procedure TBoldIOTAEditorNotifier.ViewNotification(
  const View: IOTAEditView; Operation: TOperation);
begin
  // Nothing implemented here
end;

procedure TBoldOTAFileHandler.CloseFile;
begin
  if not OTASourceEditor.GetModified and not fWasOpen then
  begin
    fOTAEditReader := nil;
    fOTAEditWriter := nil;
    fModuleCreator := nil;

    OTADEBUGLogFmt('%s has %d editors', [FileNAme, FOTASourceEditor.GetEditViewCount]); // do not localize

    fOTASourceEditor := nil;
    OTADEBUGLogFmt('Closing %s', [FileName]); // do not localize
    try
      if OTAModule.Close and OTADEBUG then
        BoldLog.Log('Closed '+FileName); // do not localize
    except
      on e: exception do
        BoldLog.LogFmt(sFailedToCloseModule, [FileName, e.Message]); // do not localize
    end;
    OTADEBUGLogFmt('Done Closing %s', [FileName]); // do not localize
    fOTAModule := nil;
  end;
end;

initialization
  BoldPrefferedFileHandlerClass := TBoldOTAFileHandler;

end.
