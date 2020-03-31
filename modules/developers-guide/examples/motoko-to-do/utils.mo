// Import standard libraries
import Array "mo:stdlib/Array";
import Nat "mo:stdlib/Nat";

// Import type properties for the ToDo type definition
import types "./types";

type ToDo = types.ToDo;

// Add to-do item utility
func add(todos : [ToDo], desc : Text, nextId : Nat) : [ToDo] {
	let todo : ToDo = {
		id = nextId; 
		description = desc; 
		completed = false; 
	};
	Array.append<ToDo>(todos, [todo])
};

// Complete to-do item utility
func complete(todos : [ToDo], id : Nat) : [ToDo] {
	Array.map<ToDo,ToDo>(func (todo : ToDo) : ToDo {
		if (todo.id == id) {
			return { 
				id = todo.id; 
				description = todo.description;
				completed = true; 
			};
		};
		todo
	}, todos)
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

// Clear to-do item utility
func clear(todos: [ToDo]) : [ToDo] {
	var updated : [ToDo] = [];
	for (todo : ToDo in todos.vals()) {
		if (not todo.completed) {
			updated := Array.append<ToDo>(updated, [todo]);
		};
	};
	updated
};
