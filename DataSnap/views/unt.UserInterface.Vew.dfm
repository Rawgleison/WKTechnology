object frmUserInterface: TfrmUserInterface
  Left = 271
  Top = 114
  BorderStyle = bsDialog
  ClientHeight = 248
  ClientWidth = 317
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 180
    Top = 25
    Width = 38
    Height = 25
    Caption = 'Port'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -21
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object ButtonStart: TButton
    Left = 8
    Top = 8
    Width = 161
    Height = 55
    Caption = 'Start'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -29
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    OnClick = ButtonStartClick
  end
  object edtServerPort: TEdit
    Left = 224
    Top = 19
    Width = 81
    Height = 37
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -24
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
    Text = '8080'
  end
  object gbDBConfig: TGroupBox
    Left = 8
    Top = 97
    Width = 297
    Height = 136
    Caption = 'Dados de conex'#227'o'
    TabOrder = 2
    object edtConnectionHost: TLabeledEdit
      Left = 16
      Top = 32
      Width = 121
      Height = 21
      EditLabel.Width = 22
      EditLabel.Height = 13
      EditLabel.Caption = 'Host'
      TabOrder = 0
      Text = 'localhost'
    end
    object edtConnectionPorta: TLabeledEdit
      Left = 160
      Top = 32
      Width = 121
      Height = 21
      EditLabel.Width = 26
      EditLabel.Height = 13
      EditLabel.Caption = 'Porta'
      TabOrder = 1
      Text = '5432'
    end
    object edtConnectionUserName: TLabeledEdit
      Left = 16
      Top = 72
      Width = 121
      Height = 21
      EditLabel.Width = 36
      EditLabel.Height = 13
      EditLabel.Caption = 'Usu'#225'rio'
      TabOrder = 2
      Text = 'postgres'
    end
    object edtConnectionPassword: TLabeledEdit
      Left = 160
      Top = 72
      Width = 121
      Height = 21
      EditLabel.Width = 30
      EditLabel.Height = 13
      EditLabel.Caption = 'Senha'
      PasswordChar = '*'
      TabOrder = 3
      Text = '1234'
    end
    object edtConnectionDatabase: TLabeledEdit
      Left = 16
      Top = 112
      Width = 121
      Height = 21
      EditLabel.Width = 76
      EditLabel.Height = 13
      EditLabel.Caption = 'Banco de dados'
      TabOrder = 4
      Text = 'postgres'
    end
  end
  object chkInicioAutomatico: TCheckBox
    Left = 8
    Top = 69
    Width = 97
    Height = 17
    Caption = 'Auto Iniciar'
    TabOrder = 3
  end
  object ApplicationEvents1: TApplicationEvents
    OnIdle = ApplicationEvents1Idle
    Left = 152
    Top = 135
  end
end
