object BoldLogForm: TBoldLogForm
  Left = 477
  Top = 234
  Width = 469
  Height = 347
  Caption = 'Bold'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Icon.Data = {
    0000010001002020100000000000E80200001600000028000000200000004000
    0000010004000000000080020000000000000000000000000000000000000000
    000000008000008000000080800080000000800080008080000080808000C0C0
    C0000000FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF001111
    1111111111111111111111111111111111111111111111111111111111111111
    1111111111111111111111111111111111111111111111111111111111111111
    1111111111111111111111111111111111111111111111111111111111111111
    1111111111111111111111111111111111111111111111111111111111111111
    1111111111111111111111111111111111111111111111111111111111111111
    1111111111111111111111111111111111111111111111111111111111111111
    1111111111111111111111111111111111111111111111111111111111111111
    11111111111111111111111111111111111111111111111111111111111111FF
    FFF11111FFF111FF711FFF1FF71111FFFFFF111FFFFF11FF81FFFFFFF81111FF
    11FFF1FF818FF1FF71FF91FFF71111FF111FF1FF119FF1FF98FF111FF81111FF
    111FF1FF111FF1FF7FF8111FF71111FF111FF1FF111FF1FF9FF8111FF81111FF
    FFFF11FF119FF1FF78FF111FF71111FFFFF111FF81FFF1FF99FF118FF81111FF
    11FF111FFFFF11FF71FFFFFFF71111FF111FF111FFF111FF917FFF1FF81111FF
    111FF111111111FF7111111FF71111FF91FF9111111111FF9111111FF81111FF
    FFFF1111111111FF7111111FF71111FFFF991111111111FF9111111FF8111111
    1111111111111111111111111111111111111111111111111111111111110000
    0000000000000000000000000000000000000000000000000000000000000000
    0000000000000000000000000000000000000000000000000000000000000000
    0000000000000000000000000000000000000000000000000000000000000000
    000000000000000000000000000000000000000000000000000000000000}
  Menu = MainMenu1
  OldCreateOrder = True
  Position = poScreenCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object Log: TRichEdit
    Left = 0
    Top = 0
    Width = 461
    Height = 281
    Align = alClient
    ReadOnly = True
    ScrollBars = ssBoth
    TabOrder = 0
  end
  object Panel1: TPanel
    Left = 0
    Top = 281
    Width = 461
    Height = 20
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 1
    object ProgressBar1: TProgressBar
      Left = 0
      Top = 0
      Width = 461
      Height = 20
      Align = alClient
      Step = 1
      TabOrder = 0
    end
  end
  object MainMenu1: TMainMenu
    Images = ImageList1
    Left = 8
    Top = 8
    object File1: TMenuItem
      Caption = '&File'
      object mnuClearLog: TMenuItem
        Caption = 'Clear Log'
        OnClick = mnuClearLogClick
      end
      object SaveLog1: TMenuItem
        Caption = '&Save Log'
        ImageIndex = 0
        OnClick = cmdSaveClick
      end
      object N1: TMenuItem
        Caption = '-'
      end
      object mnuCloseLogForm: TMenuItem
        Caption = 'Close log form'
        ImageIndex = 1
        OnClick = cmdCloseClick
      end
    end
    object Edit1: TMenuItem
      Caption = '&Edit'
      object mnuAddSeparator: TMenuItem
        Caption = 'Add Separator'
        OnClick = mnuAddSeparatorClick
      end
      object mnuCopy: TMenuItem
        Caption = '&Copy'
        ImageIndex = 2
        ShortCut = 16451
        OnClick = mnuCopyClick
      end
      object mnuShowAll: TMenuItem
        Caption = 'Show all log'
        OnClick = mnuShowAllClick
      end
    end
  end
  object ImageList1: TImageList
    Left = 44
    Top = 8
    Bitmap = {
      494C010103000400040010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000001000000001002000000000000010
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000084848400FFFF
      FF00848484000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF008484840084848400FFFF
      FF008484840084848400FFFFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000008484000084
      8400000000000000000000000000000000000000000000000000C6C6C600C6C6
      C600000000000084840000000000000000008484840000000000000000000000
      00000000000000000000000000000000000084848400FFFFFF0084848400FFFF
      FF0084848400FFFFFF0084848400000000000000000000000000000000000000
      0000000000000000000084000000840000008400000084000000840000008400
      0000840000008400000084000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000008484000084
      8400000000000000000000000000000000000000000000000000C6C6C600C6C6
      C600000000000084840000000000000000000000000000000000000000000000
      0000000000000000000000000000848484008484840084848400FFFFFF00FFFF
      FF00FFFFFF008484840084848400848484000000000000000000000000000000
      0000000000000000000084000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0084000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000008484000084
      8400000000000000000000000000000000000000000000000000C6C6C600C6C6
      C600000000000084840000000000000000000000000000000000000000000000
      0000000000000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000000000000000000000000
      0000000000000000000084000000FFFFFF000000000000000000000000000000
      000000000000FFFFFF0084000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000008484000084
      8400000000000000000000000000000000000000000000000000000000000000
      0000000000000084840000000000000000000000000000000000000000000000
      0000000000000000000000000000848484008484840084848400FFFFFF00FFFF
      FF00FFFFFF008484840084848400848484000000000000000000000000000000
      0000000000000000000084000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0084000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000008484000084
      8400008484000084840000848400008484000084840000848400008484000084
      8400008484000084840000000000000000000000000000000000000000000000
      00000000000000000000000000000000000084848400FFFFFF0084848400FFFF
      FF0084848400FFFFFF00848484000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0084000000FFFFFF000000000000000000000000000000
      000000000000FFFFFF0084000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000008484000084
      8400000000000000000000000000000000000000000000000000000000000000
      0000008484000084840000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF008484840084848400FFFF
      FF008484840084848400FFFFFF000000000000000000FFFFFF00000000000000
      0000000000000000000084000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0084000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000008484000000
      0000C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6
      C6000000000000848400000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF0000000000000000000000000084848400FFFF
      FF008484840000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0084000000FFFFFF000000000000000000FFFFFF008400
      0000840000008400000084000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000008484000000
      0000C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6
      C6000000000000848400000000000000000000000000FFFFFF00000000000000
      00000000000000000000FFFFFF00000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00000000000000
      0000000000000000000084000000FFFFFF00FFFFFF00FFFFFF00FFFFFF008400
      0000FFFFFF008400000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000008484000000
      0000C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6
      C6000000000000848400000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0084000000FFFFFF00FFFFFF00FFFFFF00FFFFFF008400
      0000840000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000008484000000
      0000C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6
      C6000000000000848400000000000000000000000000FFFFFF00000000000000
      00000000000000000000FFFFFF00000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00000000000000
      0000FFFFFF000000000084000000840000008400000084000000840000008400
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000008484000000
      0000C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6
      C6000000000000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF0000000000FFFFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000008484000000
      0000C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6
      C60000000000C6C6C600000000000000000000000000FFFFFF0000000000FFFF
      FF00000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF0000000000FFFFFF0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000040000000100000000100010000000000800000000000000000000000
      000000000000000000000000FFFFFF00FFFFFFC7FFFF0000C001F701FFFF0000
      80010301FC01000080010200FC01000080017600FC01000080017E0000010000
      8001FF01000100008001000100010000800100C700010000800100FF00030000
      800100FF00070000800100FF000F0000800100FF00FF0000800100FF01FF0000
      800101FF03FF0000FFFF03FFFFFF000000000000000000000000000000000000
      000000000000}
  end
end
