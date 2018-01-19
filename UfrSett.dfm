object frSett: TfrSett
  Left = 0
  Top = 0
  BorderStyle = bsToolWindow
  Caption = #1053#1072#1089#1090#1088#1086#1081#1082#1080
  ClientHeight = 259
  ClientWidth = 362
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnClose = FormClose
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 16
  object sButton1: TsButton
    Left = 284
    Top = 231
    Width = 75
    Height = 25
    Caption = 'OK'
    Default = True
    TabOrder = 0
    OnClick = sButton1Click
    SkinData.SkinSection = 'BUTTON'
  end
  object PageControl1: TPageControl
    AlignWithMargins = True
    Left = 3
    Top = 3
    Width = 356
    Height = 222
    ActivePage = TabSheet1
    Align = alTop
    TabOrder = 1
    object TabSheet1: TTabSheet
      Caption = #1041#1044
      object sGroupBox1: TsGroupBox
        Left = 3
        Top = 6
        Width = 341
        Height = 182
        Caption = #1053#1072#1089#1090#1088#1086#1081#1082#1080' '#1087#1086#1076#1082#1083#1102#1095#1077#1085#1080#1103
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        SkinData.SkinSection = 'GROUPBOX'
        object Label4: TLabel
          Left = 16
          Top = 121
          Width = 75
          Height = 16
          Caption = #1041#1072#1079#1072' '#1076#1072#1085#1085#1099#1093
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
        end
        object Label1: TLabel
          Left = 16
          Top = 25
          Width = 43
          Height = 16
          Caption = #1057#1077#1088#1074#1077#1088
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
        end
        object Label2: TLabel
          Left = 16
          Top = 57
          Width = 83
          Height = 16
          Caption = #1055#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1100
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
        end
        object Label3: TLabel
          Left = 16
          Top = 89
          Width = 43
          Height = 16
          Caption = #1055#1072#1088#1086#1083#1100
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
        end
        object Label6: TLabel
          Left = 16
          Top = 153
          Width = 28
          Height = 16
          Caption = #1055#1086#1088#1090
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
        end
        object edHost: TEdit
          Left = 105
          Top = 25
          Width = 221
          Height = 24
          TabOrder = 0
        end
        object edUser: TEdit
          Left = 105
          Top = 55
          Width = 221
          Height = 24
          TabOrder = 1
        end
        object edDatabase: TEdit
          Left = 105
          Top = 120
          Width = 221
          Height = 24
          TabOrder = 2
        end
        object edPassword: TEdit
          Left = 105
          Top = 87
          Width = 221
          Height = 24
          PasswordChar = '*'
          TabOrder = 3
        end
        object edPort: TEdit
          Left = 105
          Top = 150
          Width = 221
          Height = 24
          NumbersOnly = True
          TabOrder = 4
        end
      end
    end
  end
end
