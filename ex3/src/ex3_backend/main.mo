import Buffer "mo:base/Buffer";
import Text "mo:base/Text";

actor {
  var pessoas : Buffer.Buffer<Text> = Buffer.Buffer<Text>(0);

  public func adicionarPessoas(nomePessoa: Text) : async () {
    pessoas.add(nomePessoa);
  };

  public func listarPessoas() : async [Text] {
    return Buffer.toArray(pessoas);
  };
};
