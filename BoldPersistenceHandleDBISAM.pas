unit BoldPersistenceHandleDBISAM;

interface

uses
  Classes,
  db,
  dbisamtb,
  BoldDBInterfaces,
  BoldDBISAMInterfaces,
  BoldPersistenceHandleDB,
  BoldDatabaseAdapterDBIsam,
  BoldPersistenceHandleDB_deprecated;

type
  { forward declarations }
  TBoldPersistenceHandleDBISAM = class;

  { TBoldPersistenceHandleDBISAM }
  TBoldPersistenceHandleDBISAM = class(TBoldDBPersistenceHandle)
  private
    fDataBase: TDBISAMDataBase;
    fDataBaseAdapter: TBoldDBISAMDataBase;
    procedure SetDataBase(const Value: TDBISAMDatabase);
  protected
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    {$IFNDEF T2H}
    procedure InternalTransferproperties(const target: TBoldPersistenceHandleDB); override;
    {$ENDIF}
  public
    constructor Create(Owner: TComponent); override;
    destructor Destroy; override;
    function GetDataBaseInterface: IBoldDatabase; override;
  published
    property DataBase: TDBISAMDatabase read fDataBase write SetDataBase;
  end deprecated;

implementation

uses
  SysUtils,
  Dialogs,
  BoldSQLDatabaseConfig;

{ TBoldPersistenceHandleDBISAM }

constructor TBoldPersistenceHandleDBISAM.create(Owner: TComponent);
begin
  inherited;
  DatabaseEngine := dbeDBISAM;
end;

destructor TBoldPersistenceHandleDBISAM.destroy;
begin
  Active := false;
  FreeAndNil(fDataBaseAdapter);
  inherited;
end;

function TBoldPersistenceHandleDBISAM.GetDataBaseInterface: IBoldDatabase;
begin
  if not assigned(fDataBaseAdapter) then
    fDataBaseAdapter := TBoldDBISAMDataBase.create(DataBase, SQLDataBaseConfig);
  result := fDataBaseAdapter;
end;

procedure TBoldPersistenceHandleDBISAM.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited;
  if (aComponent = fDataBase) and (Operation = opRemove) then
  begin
    Active := false;
    fDataBaseAdapter := nil;
    fDataBase := nil;
  end;
end;

procedure TBoldPersistenceHandleDBISAM.SetDataBase(const Value: TDBISAMDatabase);
begin
  if fDataBase <> Value then
  begin
    CheckInactive('SetDataBase'); // do not localize
    fDataBase := Value;
    if assigned(fDataBase) then
      fDataBase.FreeNotification(self);
  end;
end;

procedure TBoldPersistenceHandleDBISAM.InternalTransferproperties(
  const target: TBoldPersistenceHandleDB);
var
  Adapter: TBoldDatabaseAdapterDBISAM;
  DesInfo: longint;
begin
  inherited;
  DesInfo := Target.DesignInfo;
  if not assigned(Target.DatabaseAdapter) then
  begin
    Target.DatabaseAdapter := TBoldDatabaseAdapterDBISAM.Create(Target.Owner);
    Target.DatabaseAdapter.Name := GetNewComponentName(Target.DatabaseAdapter, 'BoldDatabaseAdapterDBISAM'); // do not localize
    LongRec(DesInfo).Lo := LongRec(DesInfo).lo+16; //set Left
    LongRec(DesInfo).Hi := LongRec(DesInfo).hi+16; //Set Top;
    Target.DatabaseAdapter.DesignInfo          := DesInfo;
    showmessage(sCreatedNewAdapter);
  end
  else if not (target.DatabaseAdapter is tBoldDatabaseAdapterDBISAM) then
    raise Exception.CreateFmt(sCannotTransferProperties, [target.DatabaseAdapter.ClassName] );

  Adapter := target.DatabaseAdapter as tBoldDatabaseAdapterDBISAM;
  if assigned(fDatabase) then
    Adapter.DataBase := DataBase;

  if not assigned(Adapter.Database) then
  begin
    Adapter.DataBase := TDBISAMDatabase.Create(Target.owner);
    Adapter.DataBase.Name := GetNewComponentName(Adapter.DataBase, 'Database'); // do not localize
    showmessage(sCreatedDB);
    LongRec(DesInfo).Lo := LongRec(DesInfo).lo+16; //set Left
    LongRec(DesInfo).Hi := LongRec(DesInfo).hi+16; //Set Top;
    Adapter.DataBase.DesignInfo          := DesInfo;
  end;
end;

end.


