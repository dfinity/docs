import Array "mo:base/Array";
import Nat "mo:base/Nat";

// Define the actor
actor Assistant {

	stable var todos : [ToDo] = [];
	stable var nextId : Nat = 1;

// Define to-do item properties
type ToDo = {
	id: Nat;
	description: Text;
	completed: Bool;
};

  // Add to-do item utility
  func add(todos : [ToDo], desc : Text, nextId : Nat) : [ToDo] {
    let todo : ToDo = {
      id = nextId;
      description = desc;
      completed = false;
    };
    Array.append<ToDo>(todos, [todo])
};

  // Show to-do item utility
  func show(todos : [ToDo]) : Text {
    var output : Text = "\n___TO-DOs___";
    for (todo : ToDo in todos.vals()) {
      output #= "\n(" # Nat.toText(todo.id) # ") " # todo.description;
      if (todo.completed) { output #= " ✔"; };
    };
    output
  };

  public func addTodo (description : Text) : async () {
    todos := add(todos, description, nextId);
    nextId += 1;
  };

  public query func showTodos () : async Text {
    show(todos)
  };

};
