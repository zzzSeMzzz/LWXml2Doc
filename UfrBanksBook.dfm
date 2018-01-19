object frBanksBook: TfrBanksBook
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMaximize]
  Caption = #1057#1087#1088#1072#1074#1086#1095#1085#1080#1082' '#1073#1072#1085#1082#1080
  ClientHeight = 373
  ClientWidth = 732
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  ShowHint = True
  OnClose = FormClose
  DesignSize = (
    732
    373)
  PixelsPerInch = 96
  TextHeight = 16
  object DBGrid1: TDBGrid
    AlignWithMargins = True
    Left = 3
    Top = 3
    Width = 726
    Height = 323
    Align = alTop
    Anchors = [akLeft, akTop, akRight, akBottom]
    DataSource = dm.dsBanks
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -13
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    Columns = <
      item
        Expanded = False
        FieldName = 'id'
        Width = -1
        Visible = False
      end
      item
        Expanded = False
        FieldName = 'name'
        Title.Caption = #1053#1072#1079#1074#1072#1085#1080#1077
        Width = 270
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'bik'
        Title.Caption = #1041#1048#1050
        Width = 140
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'ks'
        Title.Caption = #1050#1057
        Width = 240
        Visible = True
      end>
  end
  object DBNavigator1: TDBNavigator
    Left = 3
    Top = 332
    Width = 240
    Height = 33
    DataSource = dm.dsBanks
    VisibleButtons = [nbInsert, nbDelete, nbEdit, nbPost, nbCancel]
    Anchors = [akLeft, akBottom]
    TabOrder = 1
  end
end
