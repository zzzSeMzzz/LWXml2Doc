object dm: Tdm
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 219
  Width = 626
  object cn: TMyConnection
    Database = 'lwxmltodoc'
    Options.Charset = 'cp1251'
    Username = 'root'
    Server = 'localhost'
    LoginPrompt = False
    Left = 8
    EncryptedPassword = '8DFF90FF90FF8BFF'
  end
  object usersQuery: TMyQuery
    Connection = cn
    SQL.Strings = (
      'select * from users')
    Left = 16
    Top = 48
  end
  object userDS: TMyDataSource
    DataSet = usersQuery
    Left = 72
    Top = 48
  end
  object qIfns: TMyQuery
    SQLInsert.Strings = (
      'INSERT INTO ifns'
      '  (name)'
      'VALUES'
      '  (:name)')
    SQLDelete.Strings = (
      'DELETE FROM ifns'
      'WHERE'
      '  name = :Old_name')
    SQLUpdate.Strings = (
      'UPDATE ifns'
      'SET'
      '  name = :name'
      'WHERE'
      '  name = :Old_name')
    SQLRefresh.Strings = (
      'SELECT name FROM ifns'
      'WHERE'
      '  name = :name')
    SQLLock.Strings = (
      'SELECT * FROM ifns'
      'WHERE'
      '  name = :Old_name'
      'FOR UPDATE')
    SQLRecCount.Strings = (
      'SELECT COUNT(*) FROM ifns')
    Connection = cn
    SQL.Strings = (
      'select * from ifns')
    Left = 8
    Top = 104
  end
  object dsIfns: TMyDataSource
    DataSet = qIfns
    Left = 64
    Top = 104
  end
  object qNalog: TMyQuery
    SQLInsert.Strings = (
      'INSERT INTO nalog'
      '  (name)'
      'VALUES'
      '  (:name)')
    SQLDelete.Strings = (
      'DELETE FROM nalog'
      'WHERE'
      '  name = :Old_name')
    SQLUpdate.Strings = (
      'UPDATE nalog'
      'SET'
      '  name = :name'
      'WHERE'
      '  name = :Old_name')
    SQLRefresh.Strings = (
      'SELECT name FROM nalog'
      'WHERE'
      '  name = :name')
    SQLLock.Strings = (
      'SELECT * FROM nalog'
      'WHERE'
      '  name = :Old_name'
      'FOR UPDATE')
    SQLRecCount.Strings = (
      'SELECT COUNT(*) FROM nalog')
    Connection = cn
    SQL.Strings = (
      'select * from nalog')
    Left = 128
    Top = 48
  end
  object dsNalog: TMyDataSource
    DataSet = qNalog
    Left = 176
    Top = 48
  end
  object qAccount: TMyQuery
    SQLInsert.Strings = (
      'INSERT INTO accounts'
      '  (name)'
      'VALUES'
      '  (:name)')
    SQLDelete.Strings = (
      'DELETE FROM accounts'
      'WHERE'
      '  name = :Old_name')
    SQLUpdate.Strings = (
      'UPDATE accounts'
      'SET'
      '  name = :name'
      'WHERE'
      '  name = :Old_name')
    SQLRefresh.Strings = (
      'SELECT name FROM accounts'
      'WHERE'
      '  name = :name')
    SQLLock.Strings = (
      'SELECT * FROM accounts'
      'WHERE'
      '  name = :Old_name'
      'FOR UPDATE')
    SQLRecCount.Strings = (
      'SELECT COUNT(*) FROM accounts')
    Connection = cn
    SQL.Strings = (
      'select * from accounts')
    Left = 128
    Top = 112
  end
  object dsAccount: TMyDataSource
    DataSet = qAccount
    Left = 192
    Top = 112
  end
  object qBanks: TMyQuery
    SQLInsert.Strings = (
      'INSERT INTO banks'
      '  (id, name, bik, ks)'
      'VALUES'
      '  (:id, :name, :bik, :ks)')
    SQLDelete.Strings = (
      'DELETE FROM banks'
      'WHERE'
      '  id = :Old_id')
    SQLUpdate.Strings = (
      'UPDATE banks'
      'SET'
      '  id = :id, name = :name, bik = :bik, ks = :ks'
      'WHERE'
      '  id = :Old_id')
    SQLRefresh.Strings = (
      'SELECT id, name, bik, ks FROM banks'
      'WHERE'
      '  id = :id')
    SQLLock.Strings = (
      'SELECT * FROM banks'
      'WHERE'
      '  id = :Old_id'
      'FOR UPDATE')
    SQLRecCount.Strings = (
      'SELECT COUNT(*) FROM banks')
    Connection = cn
    SQL.Strings = (
      'select * from banks')
    Left = 280
    Top = 56
  end
  object dsBanks: TMyDataSource
    DataSet = qBanks
    Left = 336
    Top = 56
  end
end
