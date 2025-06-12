import Nat "mo:base/Nat";
import Text "mo:base/Text";
import Int "mo:base/Int";

actor {
  var numero1 : Nat = 10;
  var numero2 : Int = 20;
  var info : Text = "Meu primeiro Dapp";

  public func somar(x: Nat, y: Nat) : async Nat {
    let result : Nat = x + y;
    return result;
  };

  public func subtrair(x: Nat, y: Nat) : async Nat {
    if( x < y) { // para o caso em que y > x, evitando o erro de subtração negativa, retornando 0 nesse caso
      return 0; 
    };
    
    let resultado : Nat = x - y;
    return resultado;
  };

  public func multiplicar(x : Nat, y : Nat) : async Nat {
    let resultado : Nat = x * y;
    return resultado;
  }
};
