unit BoldMemberTypeDictionary;

interface

uses
  BoldIndexableList,
  BoldDefs;

type
  TBoldMemberTypeList = class;
  TBoldMemberTypeDescriptor = class;

  {---TBoldMemberTypeList---}
  TBoldMemberTypeList = class(TBoldIndexableList)
  private
    function GetDescriptorByClass(BoldMemberClass: TClass): TBoldMemberTypeDescriptor;
    function GetMemberTypeDescriptors(index: integer): TBoldMemberTypeDescriptor;
    function GetDescriptorByDelphiName(DelphiName: string): TBoldMemberTypeDescriptor;
  public
    constructor Create;
    procedure AddMemberTypeDescriptor(MemberClass: TClass;
                                      const AbstractionLevel: TBoldAbstractionLevel);
    procedure RemoveDescriptorByClass(BoldMemberClass: TClass);
    property DescriptorByDelphiName[DelphiName: string]: TBoldMemberTypeDescriptor read GetDescriptorByDelphiName;
    property DescriptorByClass[BoldMemberClass: TClass]: TBoldMemberTypeDescriptor read GetDescriptorByClass;
    property Descriptors[Index: integer]: TBoldMemberTypeDescriptor read GetMemberTypeDescriptors;
  end;

  {---TBoldMemberTypeDescriptor---}
  TBoldMemberTypeDescriptor = class
  private
    fMemberClass: TClass;
    fAbstractionLevel: TBoldAbstractionLevel;
  public
    constructor Create(MemberClass: TClass;
                       const AbstractionLevel: TBoldAbstractionLevel);
    property MemberClass: TClass read fMemberClass;
    property AbstractionLevel: TBoldAbstractionLevel read fAbstractionLevel;
  end;

  {---Access methods for registry objects---}

function BoldMemberTypes: TBoldMemberTypeList;
function BoldMemberTypesAssigned: Boolean;

implementation

uses
  SysUtils,
  BoldHashIndexes;

var
  G_BoldMemberTypes: TBoldMemberTypeList;

var
  IX_MemberName: integer = -1;
  IX_MemberClass: integer = -1;

type
{---TMemberNameIndex---}
  TMemberNameIndex = class(TBoldStringHashIndex)
  protected
    function ItemAsKeyString(Item: TObject): string; override;
  end;

{---TMemberClassIndex---}
  TMemberClassIndex = class(TBoldClassHashIndex)
  protected
    function ItemAsKeyClass(Item: TObject): TClass; override;
  end;

{---TMemberNameIndex---}
function TMemberNameIndex.ItemAsKeyString(Item: TObject): string;
begin
  Result := TBoldMemberTypeDescriptor(Item).MemberClass.ClassName;
end;

{---TMemberClassIndex---}
function TMemberClassIndex.ItemAsKeyClass(Item: TObject): TClass;
begin
  Result := TBoldMemberTypeDescriptor(Item).MemberClass;
end;

{---Access methods for registry objects---}

function BoldMemberTypes: TBoldMemberTypeList;
begin
  if not Assigned(G_BoldMemberTypes) then
    G_BoldMemberTypes := TBoldMemberTypeList.Create;
  Result := G_BoldMemberTypes;
end;

function BoldMemberTypesAssigned: Boolean;
begin
  Result := Assigned(G_BoldMemberTypes);
end;

{---TBoldMemberTypeList---}
constructor TBoldMemberTypeList.Create;
begin
  inherited;
  SetIndexCapacity(2);
  SetIndexVariable(IX_MemberName, AddIndex(TMemberNameIndex.Create));
  SetIndexVariable(IX_MemberClass, AddIndex(TMemberClassIndex.Create));
end;

function TBoldMemberTypeList.GetDescriptorByDelphiName(DelphiName: string): TBoldMemberTypeDescriptor;
begin
  Result := TBoldMemberTypeDescriptor(TMemberNameIndex(Indexes[IX_MemberName]).FindByString(DelphiName))
end;

function TBoldMemberTypeList.GetDescriptorByClass(BoldMemberClass: TClass): TBoldMemberTypeDescriptor;
begin
  Result := TBoldMemberTypeDescriptor(TMemberClassIndex(Indexes[IX_MemberClass]).FindByClass(BoldMemberClass))
end;

procedure TBoldMemberTypeList.AddMemberTypeDescriptor(MemberClass: TClass;
                                                      const AbstractionLevel: TBoldAbstractionLevel);
begin
  Add(TBoldMemberTypeDescriptor.Create(MemberClass, AbstractionLevel));
end;

procedure TBoldMemberTypeList.RemoveDescriptorByClass(BoldMemberClass: TClass);
begin
  Remove(DescriptorByClass[BoldMemberClass]);
end;

function TBoldMemberTypeList.GetMemberTypeDescriptors(index: integer): TBoldMemberTypeDescriptor;
begin
  Result := TBoldMemberTypeDescriptor(Items[index]);
end;

{---TBoldMemberTypeDescriptor---}
constructor TBoldMemberTypeDescriptor.Create(MemberClass: TClass;
                                                const AbstractionLevel: TBoldAbstractionLevel);
begin
  fMemberClass := MemberClass;
  fAbstractionLevel := AbstractionLevel;
end;

initialization

finalization
  FreeAndNil(G_BoldMemberTypes);

end.
