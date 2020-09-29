import Nat "mo:base/Nat";

var count: Nat = 0;
var output : Text = "Welcome to the simplified developer preview, ";

actor HelloActor {

   public func whoami(name: Text) : async Text {
      count += 1;
      return output # name # ": " # Nat.toText(count)
   };

   public query func get() : async Text {
      return "Your counter value is: " # Nat.toText(count);
   };
};
