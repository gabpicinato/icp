import Buffer "mo:base/Buffer";
import Nat "mo:base/Nat";
import Text "mo:base/Text";
import Bool "mo:base/Bool";
import Principal "mo:base/Principal";

actor {
  public shared (message) func get_principal_client() : async Text {
    return "Principal: " # Principal.toText(message.caller) # "!";
  };

  type Tarefa = {
    id : Nat; // Identificador único da tarefa
    categoria : Text; // Categoria da tarefa
    descricao : Text; // Descrição detalhada da tarefa
    urgente : Bool; // Indica se a tarefa é urgente (true) ou não (false)
    concluida : Bool; // Indica se a tarefa foi concluída (true) ou não (false)
  };

  var idTarefa : Nat = 0; // Contador para gerar IDs únicos
  var tarefas : Buffer.Buffer<Tarefa> = Buffer.Buffer<Tarefa>(10); // Buffer para armazenar as tarefas

  public func addTarefa(desc : Text, cat : Text, urg : Bool, con : Bool) : async () {
    idTarefa += 1; // Incrementa o ID da tarefa
    let t : Tarefa = {
      id = idTarefa;
      categoria = cat;
      descricao = desc;
      urgente = urg;
      concluida = con;
    };
    tarefas.add(t);
  };

  public func excluirTarefa(idExcluir : Nat) : async () {
    func localizaExcluir(i : Nat, x : Tarefa) : Bool {
      return x.id != idExcluir;
    };

    tarefas.filterEntries(localizaExcluir);

  };

  // Função para alterar itens ao buffer 'tarefas'.
  public func alterarTarefa(idTar : Nat, cat : Text, desc : Text, urg : Bool, con : Bool) : async () {
    let t : Tarefa = {
      id = idTar;
      categoria = cat;
      descricao = desc;
      urgente = urg;
      concluida = con;
    };

    func localizaIndex(x : Tarefa, y : Tarefa) : Bool {
      return x.id == y.id;
    };

    let index : ?Nat = Buffer.indexOf(t, tarefas, localizaIndex);

    switch (index) {
      case (null) {
        // não foi localizado um index
      };
      case (?i) {
        tarefas.put(i, t);
      };
    };

  };

  // Função para retornar os itens do buffer 'tarefas'.
  public func getTarefas() : async [Tarefa] {
    return Buffer.toArray(tarefas);
  };

  // Função para retornar o total de tarefas em andamento
  public func totalTarefasEmAndamento() : async Nat {
    var cont : Nat = 0; // Contador para tarefas em andamento
    for (value in tarefas.vals()) {
      if (value.concluida == false) {
        // Verifica se a tarefa não está concluída
        cont += 1; // Incrementa o contador
      };
    };
    return cont; // Retorna o total de tarefas em andamento
  };

  // Função para retornar o total de tarefas concluídas
  public func totalTarefasConcluidas() : async Nat {
    var cont : Nat = 0; // Contador para tarefas em andamento
    for (value in tarefas.vals()) {
      if (value.concluida == true) {
        // Verifica se a tarefa não está concluída
        cont += 1; // Incrementa o contador
      };
    };
    return cont; // Retorna o total de tarefas concluídas
  };
};
