import Utils "utils";
import Types "types";


// Define the actor
actor Assistant {

  type ToDo = Types.ToDo;

  var todos : [ToDo] = [];
  var nextId : Nat = 1;

  public query func getTodos() : async [ToDo] {
    todos
  };

  public func addTodo(description : Text) : async () {
    todos := Utils.add(todos, description, nextId);
    nextId += 1;
  };

  public func completeTodo(id : Nat) : async () {
    todos := Utils.complete(todos, id);
  };

  public query func showTodos() : async Text {
    Utils.show(todos)
  };

  public func clearCompleted() : async () {
    todos := Utils.clear(todos);
  };
};
