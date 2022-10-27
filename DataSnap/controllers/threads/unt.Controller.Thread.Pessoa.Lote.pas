unit unt.Controller.Thread.Pessoa.Lote;

interface

uses
  System.Classes;

type
  TPessoaThread = class(TThread)
  protected
    procedure Execute; override;
  end;

implementation

{ TPessoaThread }

procedure TPessoaThread.Execute;
begin
  NameThreadForDebugging('ThInsertLote');

end;

end.
