object frAccountBook: TfrAccountBook
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMaximize]
  Caption = #1057#1087#1088#1072#1074#1086#1095#1085#1080#1082' '#1090#1080#1087' '#1089#1095#1077#1090#1072
  ClientHeight = 323
  ClientWidth = 686
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnShow = FormShow
  DesignSize = (
    686
    323)
  PixelsPerInch = 96
  TextHeight = 16
  object DBGrid1: TDBGrid
    AlignWithMargins = True
    Left = 3
    Top = 3
    Width = 680
    Height = 270
    Align = alTop
    Anchors = [akLeft, akTop, akRight, akBottom]
    DataSource = dm.dsAccount
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -13
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    Columns = <
      item
        Expanded = False
        FieldName = 'name'
        Title.Caption = #1053#1072#1079#1074#1072#1085#1080#1077
        Visible = True
      end>
  end
  object DBNavigator1: TDBNavigator
    Left = 8
    Top = 284
    Width = 305
    Height = 35
    DataSource = dm.dsAccount
    VisibleButtons = [nbInsert, nbDelete, nbEdit, nbPost, nbCancel]
    Anchors = [akLeft, akBottom]
    TabOrder = 1
  end
end
