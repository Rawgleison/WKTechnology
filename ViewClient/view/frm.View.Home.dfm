object frmHome: TfrmHome
  Left = 0
  Top = 0
  ActiveControl = Panel4
  Caption = 'frmHome'
  ClientHeight = 567
  ClientWidth = 733
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object PageControl1: TPageControl
    Left = 0
    Top = 0
    Width = 733
    Height = 567
    ActivePage = tsCadPessoa
    Align = alClient
    TabOrder = 0
    object tsCadPessoa: TTabSheet
      Caption = 'Cadastro de Pessoa'
      object pnlCadPessoa: TPanel
        Left = 0
        Top = 0
        Width = 225
        Height = 539
        Align = alLeft
        TabOrder = 0
        object Panel4: TPanel
          Left = 1
          Top = 313
          Width = 223
          Height = 225
          Align = alClient
          TabOrder = 0
          TabStop = True
          object pnlActionsCadPessoa: TPanel
            Left = 1
            Top = 159
            Width = 221
            Height = 65
            Align = alBottom
            TabOrder = 0
            TabStop = True
            object btnGravarPessoa: TBitBtn
              AlignWithMargins = True
              Left = 120
              Top = 11
              Width = 90
              Height = 43
              Margins.Left = 10
              Margins.Top = 10
              Margins.Right = 10
              Margins.Bottom = 10
              Align = alRight
              Caption = 'Gravar'
              Default = True
              Glyph.Data = {
                F6060000424DF606000000000000360000002800000018000000180000000100
                180000000000C0060000120B0000120B00000000000000000000FF00FFFF00FF
                FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
                FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
                00FFFF00FFFF00FF97433F97433F97433F97433FB59A9BB59A9BB59A9BB59A9B
                B59A9BB59A9BB59A9BB59A9BB59A9BB59A9BB59A9B97433F97433F97433F9743
                3FFF00FFFF00FFFF00FFFF00FF97433FC16967D06565C96564C45C5CA27474E9
                E2E2D5CCCCD1C0BFE9DAD8F6F0EDF6F1EFEBE6E6E3E7E6E3E7E6C27F7E932B2A
                9A3737B85353BF5F6097433FFF00FFFF00FFFF00FF97433FC46C6AD06565D069
                69CA6061A25657E9E2E292292A92292ABE6967F7EDEAFFFFFDFBF8F5F3F8F6F3
                F8F6C27F7E9227279A3636BB5454C4636397433FFF00FFFF00FFFF00FF97433F
                C36B69D06565CE6868C85F5FA35A5AE9E2E292292A92292AC36E6BEADFDDFBFA
                F7FEFAF7FDFFFCFDFFFFC27F7E9227279A3636BA5454C3626297433FFF00FFFF
                00FFFF00FF97433FC36B69D06565CE6868C75E5EA55B5BE9E2E292292A92292A
                C36E6BDACECDF0EFEDFBF7F5FFFFFFFDFFFFC27F7E9227279A3636BA5454C362
                6297433FFF00FFFF00FFFF00FF97433FC36B69D06565CE6868C75E5EA75D5CE9
                E2E292292A92292AC36E6BC1B4B3DEDEDCF2EDEAFFFFFFFDFFFFC27F7E912626
                9B3636BA5454C3626297433FFF00FFFF00FFFF00FF97433FC36B69D06565CE68
                68C55D5DA95E5EE9E2E292292A92292AC36E6BA39B9ABAC0BFDDDEDBFDFFFFFD
                FFFFC27F7E8D2222983333B95353C3626297433FFF00FFFF00FFFF00FF97433F
                C36B69D06565CD6767C75F5FB05B5CE9E2E2E9E2E2E9E2E2E9E2E2E9E2E2E9E2
                E2E9E2E2E9E2E2E9E2E2C27F7E9B3131A33E3EBD5757C3616297433FFF00FFFF
                00FFFF00FF97433FC36C69D06565CD6666CC6564C76161CD7676D99090DB9494
                D88D8ED98889D78686D48282D18282CE7575C65F5EC45B5BC65E5ECC6464C260
                6197433FFF00FFFF00FFFF00FF97433FD06565D06565C35F5EC76664CB6C6CCA
                6B6ACA6867CA6868CA6868CA6868CA6867CA6867C96766CA6B6ACE7372CF7675
                CF7272CF6969C15F6097433FFF00FFFF00FFFF00FF97433FD06565D06565D6A3
                A1D6A3A1D7A5A3D8A6A4D8A6A4D8A6A4D8A6A4D8A6A4D8A6A4D8A6A5D8A6A5D8
                A6A5D8A6A4D8A7A5D7A6A4CE7070D0656597433FFF00FFFF00FFFF00FF97433F
                D06565D06565E0C4C2FEFDFDFEFDFDFFFEFEFFFEFEFFFEFEFFFEFEFFFEFEFFFE
                FEFFFEFEFFFEFEFFFEFEFEFDFDFDFCFCE5C7C6C56666D0656597433FFF00FFFF
                00FFFF00FF97433FD06565D06565E2C8C6FEFEFEFEFEFEFEFEFEFEFEFEFEFEFE
                FEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEE5C7C7C46463D065
                6597433FFF00FFFF00FFFF00FF97433FD06565D06565E2C6C4FEFEFEFEFEFECD
                CDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDFEFEFEFEFEFE
                E5C7C6C46463D0656597433FFF00FFFF00FFFF00FF97433FD06565D06565E2C6
                C4FEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFE
                FEFEFEFEFEFEFEFEE5C7C6C46463D0656597433FFF00FFFF00FFFF00FF97433F
                D06565D06565E2C6C4FEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFE
                FEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEE5C7C6C46463D0656597433FFF00FFFF
                00FFFF00FF97433FD06565D06565E2C6C4FEFEFEFEFEFECDCDCDCDCDCDCDCDCD
                CDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDFEFEFEFEFEFEE5C7C6C46463D065
                6597433FFF00FFFF00FFFF00FF97433FD06565D06565E2C6C4FEFEFEFEFEFEFE
                FEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFE
                E5C7C6C46463D0656597433FFF00FFFF00FFFF00FF97433FD06565D06565E2C6
                C4FEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFE
                FEFEFEFEFEFEFEFEE5C7C6C46463D0656597433FFF00FFFF00FFFF00FF97433F
                D06565D06565E2C7C5FEFEFEFEFEFECDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCD
                CDCDCDCDCDCDCDCDCDCDFEFEFEFEFEFEE5C7C6C56565D0656597433FFF00FFFF
                00FFFF00FF97433FD06565D06565DDC2C0FEFEFEFEFEFEFEFEFEFEFEFEFEFEFE
                FEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEE5C8C6D06565D065
                6597433FFF00FFFF00FFFF00FFFF00FF97433F97433FCFB4B2FEFEFEFEFEFEFE
                FEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFE
                E7C9C797433F97433FFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
                FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
                00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
              TabOrder = 0
              OnClick = btnGravarPessoaClick
              ExplicitHeight = 49
            end
            object btnCancelarPessoa: TBitBtn
              AlignWithMargins = True
              Left = 10
              Top = 11
              Width = 90
              Height = 43
              Margins.Left = 10
              Margins.Top = 10
              Margins.Right = 10
              Margins.Bottom = 10
              Align = alRight
              Caption = 'Cancelar'
              Default = True
              Glyph.Data = {
                F6060000424DF606000000000000360000002800000018000000180000000100
                180000000000C0060000120B0000120B00000000000000000000FF00FFFF00FF
                FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
                FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
                00FFFF00FFFF00FF803F00803F007A3C007439006E3600683300623000602F00
                602F00602F00602F00602F00602F00602F00602F00602F00602F005E2E00562A
                00562A00FF00FFFF00FFFF00FF9C4D00924800A04F009C4D00964A009047008A
                4400844100824000824000824000824000824000824000824000824000824000
                8441008441006E3600502800562A00FF00FFFF00FF9C4D00D06700DA6C00D469
                00CE6600CA6400C66200C26000BE5E00BC5D00BC5D00BC5D00BC5D00BC5D00BC
                5D00BC5D00BC5D00BC5D00C05F00B459006E3600562A00FF00FFFF00FFB25800
                E27000E27000DA6C00D66A00D26800CE6600C86300C46100C05F00BC5D00BC5D
                00BC5D00BC5D00BC5D00BC5D00BC5D00BC5D00C05F00C05F008441005E2E00FF
                00FFFF00FFBA5C00E67200E47100DE6E00DA6C00D46900D26800CC6500C86300
                C46100BE5E00BC5D00BA5C00BA5C00BA5C00BA5C00BA5C00BA5C00BC5D00BC5D
                00844100602F00FF00FFFF00FFC26000EC7702EA7602E47302E07102DC6F02D8
                6B00D87D24D88433D48333D18133CE8033C46D18BA5C00BA5C00BA5C00BA5C00
                BA5C00BC5D00BC5D00824000602F00FF00FFFF00FFC66200F07D0BF07D0BEA78
                08E67505E27202DC6F02F3D3B3FEFEFEFEFEFEFEFEFEFEFEFEFEFEFEF8EFE6D5
                9D66BA5C00BA5C00BA5C00BC5D00BC5D00824000602F00FF00FFFF00FFC66200
                F38417F58517F18012EC7B0BE87707E47302F0BF8FF7E1CBF6E0CBF5E0CBF4E0
                CBF8ECE0FEFEFEFEFEFEE5C19EBA5C00BA5C00BC5D00BC5D00824000602F00FF
                00FFFF00FFC66200F48E2AF68F2AF4881EF2800FEE7C0BE87605E47302E06F00
                DC6D00D86B00D46900CE6600D6883CFAF3ECFEFEFECF8A48BA5C00BC5D00BC5D
                00824000602F00FF00FFFF00FFC66200F59B43F79C43F48E2AF28112F28111F0
                7B08EC7702E67200E27000DE6E00DA6C00D66A00D26800E0A266FEFEFEE8C39E
                C05F00BE5E00BC5D00824000602F00FF00FFFF00FFC66200F6A759F7A859F596
                38F38417F38417F27E0BF07902FEFEFEE87300E47100E06F00DC6D00D86B00DC
                8A39FEFEFEEFD3B6C66200C46100C05F00844100602F00FF00FFFF00FFC66200
                F7AE67F9B069F59B43F4871DF4861BF2800FFEFEFEFEFEFEF07903EA7400E672
                00E27000DC6D00E9AD72FEFEFEECC298CC6500CA6400C461008C4500683300FF
                00FFFF00FFC66200F7B370F9B573F59F4AF48921F48820FEFEFEFEFEFEFEFEFE
                F3800FF07700EC7500E67200EB9F54FCF7F2FEFCFBDE8936D06700D06700CA64
                00924800723800FF00FFFF00FFC66200F7B676F9B979F6A351F8C591FEFEFEFE
                FEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEEFB780DC6D00
                D86B00D66A00D067009A4C007C3D00FF00FFFF00FFC66200F8B87AF9BC80F7A7
                5AF9C795FEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFCFBFBE1C8F0
                A051E67200E27000DE6E00DC6D00D66A00A25000844100FF00FFFF00FFC66200
                F8BB7EF9C189F7AE66F49436F59C45FEFEFEFEFEFEFEFEFEF48B25F28112F27F
                0DF27C08F27A04F07902EC7702E87300E47100E27000DC6D00AA54008E4600FF
                00FFFF00FFC66200F8BC80FAC592F8B778F59638F59C45F5983DFEFEFEFEFEFE
                F48C26F4861BF4861BF28112F27E0BF27B05F27A02EE7600EA7400E67200E270
                00B45900964A00FF00FFFF00FFC66200F8BC80FAC897F9C592F6A759F6A351F5
                9E48F5983DFEFEFEF48F2CF48B24F48F2CF4881EF28111F27C08F27A04F27A02
                F07700EE7600E87300B85B009E4E00FF00FFFF00FFC66200F7B676FAC693F9CC
                9FF9C898F9C490F8C089F8BA7DF7B370F7AB61F6A351F59A41F48F2CF48519F2
                7F0DF27B05F27A02F27800F47900EE7600C26000A85300FF00FFFF00FFC86300
                F8AD64FABD81FAC693FACA9BFACA9BFAC897FAC38EF9BE83F9B674F8AC63F7A0
                4CF69535F68920F4810FF47D07F47B02F47900F67A00F67A00CA6400B05700FF
                00FFFF00FFC86300E67200F8AC63F7B574F8BC80F8BD83F8BC81F8B87BF7B473
                F7AE66F6A556F59B44F4912FF4861BF2800FF27C07F27A02F27800F47900EA74
                00BE5E00B05700FF00FFFF00FFFF00FFC66200C66200C66200C66200C66200C6
                6200C66200C66200C66200C66200C66200C66200C66200C66200C66200C66402
                C66200C66200BA5C00BA5C00FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
                FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
                00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
              TabOrder = 1
              OnClick = btnCancelarPessoaClick
              ExplicitHeight = 49
            end
          end
          object dbgCep: TDBGrid
            Left = 1
            Top = 1
            Width = 221
            Height = 158
            TabStop = False
            Align = alClient
            DataSource = dmHomeController.dsCEP
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            Options = [dgTitles, dgRowLines, dgConfirmDelete, dgCancelOnExit]
            ParentFont = False
            PopupMenu = ppmCEP
            TabOrder = 1
            TitleFont.Charset = DEFAULT_CHARSET
            TitleFont.Color = clWindowText
            TitleFont.Height = -16
            TitleFont.Name = 'Tahoma'
            TitleFont.Style = [fsBold]
            Columns = <
              item
                ButtonStyle = cbsEllipsis
                Expanded = False
                FieldName = 'dscep'
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWindowText
                Font.Height = -16
                Font.Name = 'Tahoma'
                Font.Style = []
                ReadOnly = True
                Title.Alignment = taCenter
                Title.Caption = 'CEP'
                Title.Color = clGray
                Title.Font.Charset = DEFAULT_CHARSET
                Title.Font.Color = clWindowText
                Title.Font.Height = -16
                Title.Font.Name = 'Tahoma'
                Title.Font.Style = []
                Width = 209
                Visible = True
              end>
          end
        end
        object pnlCamposCadPessoa: TPanel
          Left = 1
          Top = 1
          Width = 223
          Height = 312
          Align = alTop
          TabOrder = 1
          object Label1: TLabel
            Left = 8
            Top = 56
            Width = 137
            Height = 19
            Caption = 'Natureza da pessoa'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -16
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
          end
          object Label2: TLabel
            Left = 8
            Top = 200
            Width = 81
            Height = 19
            Caption = 'Documento'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -16
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
          end
          object edtnmprimeiro: TLabeledEdit
            Left = 8
            Top = 128
            Width = 143
            Height = 27
            EditLabel.Width = 107
            EditLabel.Height = 19
            EditLabel.Caption = 'Primeiro Nome'
            EditLabel.Font.Charset = DEFAULT_CHARSET
            EditLabel.Font.Color = clWindowText
            EditLabel.Font.Height = -16
            EditLabel.Font.Name = 'Tahoma'
            EditLabel.Font.Style = []
            EditLabel.ParentFont = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -16
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            TabOrder = 1
          end
          object edtnmsegundo: TLabeledEdit
            Left = 8
            Top = 176
            Width = 143
            Height = 27
            EditLabel.Width = 81
            EditLabel.Height = 19
            EditLabel.Caption = 'Sobrenome'
            EditLabel.Font.Charset = DEFAULT_CHARSET
            EditLabel.Font.Color = clWindowText
            EditLabel.Font.Height = -16
            EditLabel.Font.Name = 'Tahoma'
            EditLabel.Font.Style = []
            EditLabel.ParentFont = False
            EditLabel.Transparent = True
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -16
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            TabOrder = 2
          end
          object cbNatureza: TComboBox
            Left = 8
            Top = 80
            Width = 143
            Height = 27
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -16
            Font.Name = 'Tahoma'
            Font.Style = []
            ItemIndex = 0
            ParentFont = False
            TabOrder = 0
            Text = 'F'#205'SICA'
            OnChange = cbNaturezaChange
            Items.Strings = (
              'F'#205'SICA'
              'JUR'#205'DICA')
          end
          object medtDoc: TMaskEdit
            Left = 8
            Top = 224
            Width = 141
            Height = 27
            EditMask = '999\.999\.999\-99;0;_'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -16
            Font.Name = 'Tahoma'
            Font.Style = []
            MaxLength = 14
            ParentFont = False
            TabOrder = 3
            Text = ''
          end
          object pnlAddCep: TPanel
            Left = 1
            Top = 257
            Width = 221
            Height = 54
            Align = alBottom
            TabOrder = 4
            object Label3: TLabel
              Left = 7
              Top = -1
              Width = 28
              Height = 19
              Caption = 'CEP'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -16
              Font.Name = 'Tahoma'
              Font.Style = []
              ParentFont = False
            end
            object btnAddCep: TBitBtn
              AlignWithMargins = True
              Left = 136
              Top = 4
              Width = 81
              Height = 46
              Align = alRight
              Caption = 'Add'
              Default = True
              Glyph.Data = {
                72030000424D7203000000000000320100002800000018000000180000000100
                08000000000040020000120B0000120B00003F0000003F00000000000000FFFF
                FF00FF00FF0006770C0008780E0006770D00097711000EA51B000EA51C000EA4
                1B000EA31B000FA41D0010A61F0012A8210011A8210013A8230017AC280017AB
                290018AD2A0019AC2B001BB02F001DB132001EB032001FB1330020B2360022B4
                380024B53B0026B63D0027B7400029BA43002CBC48002BBA44002EBE4A0030BE
                4C0031C04F0033C1510036C6550037C5560038C558003BC95C003CC95E003CCC
                5F003FCC630041CF660042CE660042D0680046D46D0046D36E0046D26D0049D5
                71004CD875004CD675004DD8770050DB7B0052DD7E0051DA7C0054DD810057E1
                850056E0850059E289005AE38A005CE58C005EE8900002020202020202020202
                0202020202020202020202020202020202020202020202020202020202020202
                0202020202020202020202020202020206060606020202020202020202020202
                0202020202020203010908080602020202020202020202020202020202020203
                0109080806020202020202020202020202020202020202030109080806020202
                0202020202020202020202020202020501090808060202020202020202020202
                0202020202020204010C07070602020202020202020202020202020202020204
                01110E0E06020202020202020202020202060606060606040115121204060606
                0606060202020202060136322E2B29241D1A171314100D080707070602020202
                060136322E2B2924211F1B1814100D08070808060202020206013A3733302C28
                25221E1C1916130F0B0A09060202020206010101010101010126232001010101
                01010106020202020206060606060604012A2727040606060606060202020202
                0202020202020206012F2D2D0602020202020202020202020202020202020206
                0134313106020202020202020202020202020202020202060138353506020202
                02020202020202020202020202020206013B393E060202020202020202020202
                0202020202020206013C3D3E0602020202020202020202020202020202020206
                0101010106020202020202020202020202020202020202020606060602020202
                0202020202020202020202020202020202020202020202020202020202020202
                02020202020202020202020202020202020202020202}
              TabOrder = 1
              OnClick = btnAddCepClick
            end
            object edtCep: TMaskEdit
              Left = 7
              Top = 18
              Width = 101
              Height = 27
              BorderStyle = bsNone
              EditMask = '99999\-999;1;_'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -16
              Font.Name = 'Tahoma'
              Font.Style = []
              MaxLength = 9
              ParentFont = False
              TabOrder = 0
              Text = '     -   '
            end
          end
          object edtIdPessoa: TLabeledEdit
            Left = 8
            Top = 23
            Width = 143
            Height = 27
            TabStop = False
            EditLabel.Width = 50
            EditLabel.Height = 19
            EditLabel.Caption = 'C'#243'digo'
            EditLabel.Font.Charset = DEFAULT_CHARSET
            EditLabel.Font.Color = clWindowText
            EditLabel.Font.Height = -16
            EditLabel.Font.Name = 'Tahoma'
            EditLabel.Font.Style = []
            EditLabel.ParentFont = False
            EditLabel.Transparent = True
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -16
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            ReadOnly = True
            TabOrder = 5
          end
        end
      end
      object Panel7: TPanel
        Left = 225
        Top = 0
        Width = 500
        Height = 539
        Align = alClient
        Caption = 'Panel7'
        TabOrder = 1
        object DBGrid1: TDBGrid
          Left = 1
          Top = 1
          Width = 498
          Height = 465
          Align = alClient
          DataSource = dmHomeController.dsPessoa
          Options = [dgTitles, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgTitleHotTrack]
          PopupMenu = ppmPessoa
          TabOrder = 0
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -11
          TitleFont.Name = 'Tahoma'
          TitleFont.Style = []
          OnDblClick = DBGrid1DblClick
          Columns = <
            item
              Expanded = False
              FieldName = 'idpessoa'
              Title.Caption = 'C'#243'd'
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'flnatureza'
              PickList.Strings = (
                'F'#237'sica'
                'Jur'#237'dica')
              Title.Caption = 'Natureza'
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'dsdocumento'
              Title.Caption = 'Documento'
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'nmprimeiro'
              Title.Caption = 'Primeiro Nome'
              Width = 185
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'nmsegundo'
              Title.Caption = 'Sobrenome'
              Width = 186
              Visible = True
            end>
        end
        object pnlActionsListaPessoas: TPanel
          Left = 1
          Top = 466
          Width = 498
          Height = 72
          Align = alBottom
          TabOrder = 1
          object btnAtualizar: TBitBtn
            AlignWithMargins = True
            Left = 429
            Top = 4
            Width = 65
            Height = 64
            Align = alRight
            Glyph.Data = {
              76060000424D7606000000000000360400002800000018000000180000000100
              08000000000040020000120B0000120B0000000100000000000000000000FFFF
              FF0064636500A6A5A700A5A4A600E1E0E200F6F4F700918E92009C999D00B0AC
              B100FF00FF009F999F00868286006A676A008E8B8E005C5A5C00B8B5B8003938
              39004C4B4C0048474800CCC7CB00A0989E005A565900413E40004B484A005956
              5800615E600057535500ABA3A6006F6769003E3A3B0045414200292828002F2E
              2E00702D130076311100817A77007B34100084380F00A44909009F470A00C65C
              0400C45B0500BD570600EC720100E26B0100E06A0200D8660300F2770200F378
              0300F37A0400F3790400EF7A0600F37D0700F37E0800F47F0900F4800A00F481
              0D00F4830F00BFA58B00B7650B00F4841000F4861100F4861300F4871500F488
              1600F48A1800F48B1B00804B0F00A55F1400F48F2000C5741C00F4922500F492
              2700F6983000F69A3400DC8A2D00F69D3600F39E3B00F6A34200F6A44400E19E
              4C00F7AF5800F7B15E00F7BD7700645A4E00FE951000FE981400DC881600E38A
              1800FC9E1F00FDA02200BE791C00F3A94800F8CA90004A3D2C00FEA42300FEA5
              2500FEA72900FEA92A00FFAB2D00FEAB3900FFC67400FED9A400E0BF9100E6D7
              C200FFB13500FFB43B00BD853000FFB84200AD7E3100E6B05900A4814800896E
              4400D9B06F00FFBB4500FFBB4600FFBD4A00FFC15000FFC25300FEC25400A17F
              4600AB9E880028252000FFC55500BC924200FFC75A00FFCA5E00D0A54B00FFCB
              6000FFCF6700FFD06A00BBAF9600FFD36D00FFD57300FFD77500FFD97900FFDC
              7F00FFE08400FEE28900FEE69100BDAB6E00A9A08200FEE99600FEEB9A00B9AF
              85005C563C0076704E00B1A33A00FEF3A700A0921C00BBB65E005D5C1300A3B5
              590071971F0093B75B004E7F16003C701A00408C190035981B0043A42D003DA3
              2B0025A023002378220025A52B0025A429001AA123001CA4280011A323001BA6
              2B00262F270011A0250016632100185120001C331F00109E2600109D2800175A
              210035A04800165827001E913D00427B54000D863600135C2D000C7B3B000C7B
              3F001E6F5C000C6B5C0009635B00085B56002573760009585D000A555A005E68
              69004C5A60000C5B8900094163003C4E590007487200095383000B5C96000C52
              88002B4D6700299DFE00268FE7002A4E6B0072849300145FA0002494FB001880
              E9001B84EF001C89F4001C84ED001C83EA001871CA001F8EF800186BC0003365
              97004F647900747576001481F800157CEE001574D8001468BF0016416F002559
              93000A73F2000B74F4000C75F40008458B001079F200083E7E000F6BD4000D4F
              9D00164D9100215087000658C5000649A400053B83000969E500095CC5000959
              BF000A4CA000194277000445A300043D900005459E0007439700505051006262
              6300555556006F6F6F00656565002D2D2D00272727001E1E1E000A0A0A0A0A0A
              0A0A0A0A0A0A0A0A0A0AFAFAFAFA0A0A0A0A0A0A0A0A0A0A0A0A0A0A0A0A0A0A
              FD0D0408070D210A0A0A0A0A0A0A0A0A0A2626252322221F050504080709151F
              0A0A0A0A0A0A0A2727272828449DA3FC06090E030C18151A0A0A0A0A0A0A2B2A
              292A3C9CA8A8ACAEF91AFB03091619200A0A0A0A0A2F2D2E2D459EA8A8ACF810
              141C241D1B11FF0A0A0A0A0A2C30313234E0E7C0B9B30D6C6566676914100B0F
              FF0A0A3136383A3F40C5F4F0EDEEF3925856575A5B5D723B0E110A393F434648
              4C71F6E2E3EFECF5CA60636463625B5747123E43494A4B4EC2EAE8E6E6E4EFF7
              936B6D74736D6A615C1343494D4F51C1F2D1D7D0D2DCF1CD80777E817F7C756A
              5C1F494DA0A0B5E9D5CBCCD8D6D4E9937882868887837E736C174A94A8A8BCDE
              D0D8C9BDE5DFEB7D81878B8C8B8882766E1E4E80A7B0C7D3D6C6B6A8BFE5DA7D
              82898F95908A857C791E4F5297B4C8DDC3B8A8A8B6C4DB24848E918E8D8D8377
              70215D535491CFE8BBAFA8A8A8B75F7BFFFE13F8021A131955FF0A53545EE1F0
              BEAFA8A8A8A46F504A473C98B1ADAAFFFF0A0AA7995ECEEDD9A9A8A8A8A8A5A1
              A642379FA8A80A0A0A0A0A0AA89B68EBEAB2A8A8A8A8A8A8A24135A8A80A0A0A
              0A0A0A0A0AA89B7AEEBAABA8A8A8A8A89A3D33A80A0A0A0A0A0A0A0A0A0AA897
              72B4AFA8A8A8A8A659372C0A0A0A0A0A0A0A0A0A0A0A0AA8A4A8A8A8A8A8A896
              3A330A0A0A0A0A0A0A0A0A0A0A0A0A0A0AA8A8A8A8A89A3F0A0A0A0A0A0A0A0A
              0A0A0A0A0A0A0A0A0A0A0A0A0A0A0A0A0A0A0A0A0A0A0A0A0A0A}
            TabOrder = 0
            OnClick = btnAtualizarClick
          end
        end
      end
    end
    object tsOpcoes: TTabSheet
      Caption = 'Op'#231#245'es'
      ImageIndex = 1
      object GroupBox1: TGroupBox
        Left = 3
        Top = 19
        Width = 174
        Height = 118
        Caption = 'Op'#231#245'es da requisi'#231#227'o'
        TabOrder = 0
        object edtServidor: TLabeledEdit
          Left = 24
          Top = 32
          Width = 121
          Height = 21
          EditLabel.Width = 40
          EditLabel.Height = 13
          EditLabel.Caption = 'Servidor'
          TabOrder = 0
          OnExit = edtServidorExit
        end
        object edtPorta: TLabeledEdit
          Left = 24
          Top = 72
          Width = 121
          Height = 21
          EditLabel.Width = 26
          EditLabel.Height = 13
          EditLabel.Caption = 'Porta'
          NumbersOnly = True
          TabOrder = 1
          OnExit = edtPortaExit
        end
      end
    end
  end
  object ppmCEP: TPopupMenu
    Left = 29
    Top = 417
    object Excluir1: TMenuItem
      Bitmap.Data = {
        F6060000424DF606000000000000360000002800000018000000180000000100
        180000000000C0060000120B0000120B00000000000000000000FF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FF0732DE0732DEFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FF0732DE0732DE0732DEFF00FFFF00FFFF00FF0732DE0732DE0732
        DEFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FF0732DE0732DE0732DEFF00FFFF00FFFF00FFFF00FF
        0732DE0732DE0732DE0732DEFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FF0732DE0732DE0732DE0732DEFF00FFFF00FFFF
        00FFFF00FFFF00FF0732DE0732DE0732DE0732DE0732DEFF00FFFF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF0732DE0732DE0732DE0732DEFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF0732DE0732DE0732DE0732DE07
        32DEFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF0732DE0732DE0732DE
        0732DEFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF0335
        FB0732DE0732DE0732DE0732DEFF00FFFF00FFFF00FFFF00FFFF00FF0732DE07
        32DE0732DE0732DEFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FF0732DE0732DE0732DE0732DEFF00FFFF00FF0732
        DE0732DE0732DE0732DE0732DEFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF0732DE0732DE0732DE
        0732DE0732DE0732DE0732DE0732DE0732DEFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FF0732DE0732DE0335FB0732DE0335FB0732DE0732DEFF00FFFF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FF0732DE0732DE0732DE0335FB0732DEFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF0732DE0732DE0335FB0732DE0732
        DE0335FB0335FBFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF0732DE0732DE0335FB
        0732DE0335FB0335FB0335FB0732DE0335FBFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF0335FB03
        35FB0335FB0732DE0335FBFF00FFFF00FF0335FB0335FB0335FB0335FBFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FF0335FB0335FB0732DE0335FB0335FBFF00FFFF00FFFF00FFFF00FF0335FB03
        35FB0335FB0335FBFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FF0335FB0335FB0335FB0335FB0335FBFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FF0335FB0335FB0335FBFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FF0335FB0335FB0335FB0335FB0335FBFF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF0335FB0335FB0335FBFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FF0335FB0335FB0335FB0335FB0335FBFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FF0335FBFF00FFFF00FFFF00FFFF00FFFF00FF0335FB0335FB0335FB0335
        FB0335FBFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF0335FB
        0335FB0335FB0335FBFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FF0335FB0335FB0335FBFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
      Caption = 'Excluir'
      OnClick = Excluir1Click
    end
  end
  object ppmPessoa: TPopupMenu
    Left = 445
    Top = 232
    object Excluir2: TMenuItem
      Bitmap.Data = {
        F6060000424DF606000000000000360000002800000018000000180000000100
        180000000000C0060000120B0000120B00000000000000000000FF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FF0732DE0732DEFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FF0732DE0732DE0732DEFF00FFFF00FFFF00FF0732DE0732DE0732
        DEFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FF0732DE0732DE0732DEFF00FFFF00FFFF00FFFF00FF
        0732DE0732DE0732DE0732DEFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FF0732DE0732DE0732DE0732DEFF00FFFF00FFFF
        00FFFF00FFFF00FF0732DE0732DE0732DE0732DE0732DEFF00FFFF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF0732DE0732DE0732DE0732DEFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF0732DE0732DE0732DE0732DE07
        32DEFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF0732DE0732DE0732DE
        0732DEFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF0335
        FB0732DE0732DE0732DE0732DEFF00FFFF00FFFF00FFFF00FFFF00FF0732DE07
        32DE0732DE0732DEFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FF0732DE0732DE0732DE0732DEFF00FFFF00FF0732
        DE0732DE0732DE0732DE0732DEFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF0732DE0732DE0732DE
        0732DE0732DE0732DE0732DE0732DE0732DEFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FF0732DE0732DE0335FB0732DE0335FB0732DE0732DEFF00FFFF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FF0732DE0732DE0732DE0335FB0732DEFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF0732DE0732DE0335FB0732DE0732
        DE0335FB0335FBFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF0732DE0732DE0335FB
        0732DE0335FB0335FB0335FB0732DE0335FBFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF0335FB03
        35FB0335FB0732DE0335FBFF00FFFF00FF0335FB0335FB0335FB0335FBFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FF0335FB0335FB0732DE0335FB0335FBFF00FFFF00FFFF00FFFF00FF0335FB03
        35FB0335FB0335FBFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FF0335FB0335FB0335FB0335FB0335FBFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FF0335FB0335FB0335FBFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FF0335FB0335FB0335FB0335FB0335FBFF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF0335FB0335FB0335FBFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FF0335FB0335FB0335FB0335FB0335FBFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FF0335FBFF00FFFF00FFFF00FFFF00FFFF00FF0335FB0335FB0335FB0335
        FB0335FBFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF0335FB
        0335FB0335FB0335FBFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FF0335FB0335FB0335FBFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
      Caption = 'Excluir'
      OnClick = Excluir2Click
    end
  end
end
