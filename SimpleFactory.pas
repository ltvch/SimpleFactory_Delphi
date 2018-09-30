program SimpleFactory;
(*
  *Простая фабрика вообще не является паттерном проектирования,
  *это скорее идиома программирования (устоявшаяся практика).
*)
(*
  *Фабричный класс не должен ничего содержать, кроме создания объектов.
  *Во всем остальном коде мы не должны создавать объекты напрямую, только через фабрику.
  *В фабрике можно использовать статический метод, это избавит от создания объекта фабрики,
  *но помешает дальнейшему наследованию класса.
*)

{$APPTYPE CONSOLE}
{$R *.res}

uses
  System.SysUtils;

type
  (* abstract product as interface *)
  /// <stereotype>abstract_factory</stereotype>
  TPizza = class abstract
    function GetPizza: string; virtual; abstract;
    function GetPrice: double; virtual; abstract;
  end;

  (* concrete product *)
  TDoubleCheesePizza = class(TPizza)
    function GetPizza: string; override;
    function GetPrice: double; override;
  end;

  (* concrete product *)
  TPepperoniPizza = class(TPizza)
    function GetPizza: string; override;
    function GetPrice: double; override;
  end;

  TSimplePizzaFactory = class
  private
    fPizza: TPizza;
  public
    function CreatePizza(name: string): TPizza;
  end;

  { TDoubleCheesePizza }

function TDoubleCheesePizza.GetPizza: string;
begin
  Result := 'Its Double Cheese Pizza.';
end;

function TDoubleCheesePizza.GetPrice: double;
begin
  Result := 31.99;
end;

{ TPepperoniPizza }

function TPepperoniPizza.GetPizza: string;
begin
  Result := 'Its Pepperoni Pizza.';
end;

function TPepperoniPizza.GetPrice: double;
begin
  Result := 19.98;
end;

{ TSimplePizzaFactory }

function TSimplePizzaFactory.CreatePizza(name: string): TPizza;
begin
  if name = 'cheese' then
    fPizza := TDoubleCheesePizza.Create
  else if name = 'pepperoni' then
    fPizza := TPepperoniPizza.Create;

  Result := fPizza;
end;

var
  factory: TSimplePizzaFactory;
  pizza1, pizza2: TPizza;

begin
  try
    { TODO -oUser -cConsole Main : Insert code here }
    factory := TSimplePizzaFactory.Create;

    pizza1 := factory.CreatePizza('pepperoni');
    WriteLn(pizza1.GetPizza + ' Price: $' + FloatToStr(pizza1.GetPrice));

    pizza2 := factory.CreatePizza('cheese');
    WriteLn(pizza2.GetPizza + ' Price: $' + FloatToStr(pizza2.GetPrice));

    ReadLn;

    pizza1.Free;
    pizza2.Free;
    factory.Free;

  except
    on E: Exception do
      WriteLn(E.ClassName, ': ', E.Message);
  end;

end.
