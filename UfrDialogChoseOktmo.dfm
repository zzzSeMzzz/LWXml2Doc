object frChoseSumCash: TfrChoseSumCash
  Left = 0
  Top = 0
  BorderIcons = []
  BorderStyle = bsDialog
  Caption = #1042#1099#1073#1086#1088' '#1054#1050#1058#1052#1054' '#1080' '#1055#1086#1076#1083#1042#1086#1079#1074
  ClientHeight = 136
  ClientWidth = 324
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 16
  object Label1: TLabel
    AlignWithMargins = True
    Left = 3
    Top = 3
    Width = 318
    Height = 41
    Align = alTop
    Caption = 
      #1042#1099#1073#1077#1088#1080#1090#1077' '#1085#1091#1078#1085#1086#1077' '#1079#1085#1072#1095#1077#1085#1080#1077' '#1054#1050#1058#1052#1054' '#1080' '#1055#1086#1076#1083#1042#1086#1079#1074' '#1080#1079' '#1089#1087#1080#1089#1082#1072'. '#1047#1085#1072#1095#1077#1085#1080#1103' '#1089#1074 +
      #1103#1079#1072#1085#1099' '#1084#1077#1078#1076#1091' '#1089#1086#1073#1086#1081
    WordWrap = True
    ExplicitLeft = 8
    ExplicitTop = 0
    ExplicitWidth = 305
  end
  object Label2: TLabel
    Left = 8
    Top = 52
    Width = 56
    Height = 16
    Caption = #1055#1086#1076#1083#1042#1086#1079#1074
  end
  object Label3: TLabel
    Left = 171
    Top = 50
    Width = 43
    Height = 16
    Caption = #1054#1050#1058#1052#1054
  end
  object cbPodl: TComboBox
    Left = 8
    Top = 74
    Width = 145
    Height = 24
    Style = csDropDownList
    TabOrder = 0
    OnSelect = cbPodlSelect
  end
  object cbOktmo: TComboBox
    Left = 171
    Top = 74
    Width = 145
    Height = 24
    Style = csDropDownList
    TabOrder = 1
    OnSelect = cbOktmoSelect
  end
  object Button1: TButton
    Left = 241
    Top = 104
    Width = 75
    Height = 25
    Caption = 'OK'
    Default = True
    TabOrder = 2
    OnClick = Button1Click
  end
end
