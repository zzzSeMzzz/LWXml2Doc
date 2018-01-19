object frEditUser: TfrEditUser
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = #1056#1077#1076#1072#1082#1090#1080#1088#1086#1074#1072#1085#1080#1077' '#1087#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1077#1081
  ClientHeight = 330
  ClientWidth = 738
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnClose = FormClose
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object DBGridEh1: TDBGridEh
    Left = 8
    Top = 8
    Width = 721
    Height = 271
    DataSource = usersDs
    DynProps = <>
    TabOrder = 0
    Columns = <
      item
        CellButtons = <>
        DynProps = <>
        EditButtons = <>
        FieldName = 'id'
        Footers = <>
        Visible = False
      end
      item
        CellButtons = <>
        DynProps = <>
        EditButtons = <>
        FieldName = 'id_role'
        Footers = <>
        Visible = False
      end
      item
        CellButtons = <>
        DynProps = <>
        EditButtons = <>
        FieldName = 'login'
        Footers = <>
        Title.Caption = #1051#1086#1075#1080#1085
        Width = 150
      end
      item
        CellButtons = <>
        DynProps = <>
        EditButtons = <>
        FieldName = 'pass'
        Footers = <>
        Title.Caption = #1055#1072#1088#1086#1083#1100
        Width = 150
      end
      item
        CellButtons = <>
        DynProps = <>
        EditButtons = <>
        FieldName = 'user_name'
        Footers = <>
        Title.Caption = #1048#1084#1103
        Width = 200
      end
      item
        CellButtons = <>
        DynProps = <>
        EditButtons = <>
        FieldName = 'role'
        Footers = <>
        Title.Caption = #1055#1088#1072#1074#1072
        Width = 200
      end>
    object RowDetailData: TRowDetailPanelControlEh
    end
  end
  object DBNavigator1: TDBNavigator
    Left = 8
    Top = 285
    Width = 222
    Height = 36
    DataSource = usersDs
    VisibleButtons = [nbInsert, nbDelete, nbEdit, nbPost, nbCancel, nbRefresh]
    TabOrder = 1
    OnClick = DBNavigator1Click
  end
  object q: TMyQuery
    SQLInsert.Strings = (
      'INSERT INTO users'
      '  (id, id_role, login, pass, user_name)'
      'VALUES'
      '  (:id, :id_role, :login, :pass, :user_name)')
    SQLDelete.Strings = (
      'DELETE FROM users'
      'WHERE'
      '  id = :Old_id')
    SQLUpdate.Strings = (
      'UPDATE users'
      'SET'
      
        '  id = :id, id_role = :id_role, login = :login, pass = :pass, us' +
        'er_name = :user_name'
      'WHERE'
      '  id = :Old_id')
    SQLRefresh.Strings = (
      'SELECT id, id_role, login, pass, user_name FROM users'
      'WHERE'
      '  id = :id')
    SQLLock.Strings = (
      'SELECT * FROM users'
      'WHERE'
      '  id = :Old_id'
      'FOR UPDATE')
    SQLRecCount.Strings = (
      'SELECT COUNT(*) FROM users')
    Connection = dm.cn
    SQL.Strings = (
      'select * from users')
    Left = 392
    Top = 56
    object qid: TIntegerField
      FieldName = 'id'
    end
    object qid_role: TIntegerField
      FieldName = 'id_role'
    end
    object qlogin: TStringField
      FieldName = 'login'
      Size = 255
    end
    object qpass: TStringField
      FieldName = 'pass'
      Size = 255
    end
    object quser_name: TStringField
      FieldName = 'user_name'
      Size = 255
    end
    object qrole: TStringField
      FieldKind = fkLookup
      FieldName = 'role'
      LookupDataSet = roleQ
      LookupKeyFields = 'id'
      LookupResultField = 'name'
      KeyFields = 'id_role'
      Lookup = True
    end
  end
  object usersDs: TMyDataSource
    DataSet = q
    Left = 448
    Top = 64
  end
  object roleQ: TMyQuery
    Connection = dm.cn
    SQL.Strings = (
      'select * from user_roles')
    Left = 488
    Top = 56
  end
end
