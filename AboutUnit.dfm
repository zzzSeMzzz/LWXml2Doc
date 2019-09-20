object frAbout: TfrAbout
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = #1054' '#1087#1088#1086#1075#1088#1072#1084#1084#1077
  ClientHeight = 153
  ClientWidth = 210
  Color = clWhite
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 86
    Width = 157
    Height = 26
    Caption = #1056#1072#1079#1088#1072#1073#1086#1090#1072#1085#1086#13#10#1042#1089#1077' '#1087#1088#1072#1074#1072' '#1079#1072#1097#1080#1097#1077#1085#1099' '#169' 2019'#1075'.'
  end
  object Label2: TLabel
    Left = 73
    Top = 84
    Width = 56
    Height = 17
    Cursor = crHandPoint
    Alignment = taCenter
    AutoSize = False
    Caption = 'AlexSoft'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clNavy
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = [fsUnderline]
    ParentFont = False
    OnClick = Label2Click
  end
  object Label3: TLabel
    Left = 8
    Top = 8
    Width = 194
    Height = 40
    Caption = 'LWXml2Doc'
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = 3289650
    Font.Height = -35
    Font.Name = 'Times New Roman'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label4: TLabel
    Left = 8
    Top = 54
    Width = 54
    Height = 13
    Caption = #1042#1077#1088#1089#1080#1103' 1.3'
  end
  object Button1: TButton
    Left = 73
    Top = 118
    Width = 75
    Height = 25
    Caption = 'OK'
    Default = True
    TabOrder = 0
    OnClick = Button1Click
  end
end
