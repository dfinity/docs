author: DFINITY
summary: Data Persistence in Motoko
id: data_persistence_motoko
categories: codelab,markdown
environments: Motoko
status: Published
feedback link: https://github.com/dfinity/docs

# Data Persistence

## Introduction
Duration: 0:01:00

The Internet Computer features orthogonal persistence, which means the state of the canisters are automatically stored, so data persist when canister code is updated. Data can be stored in stable variables instead of traditional databases. 

For variables to be stable, the type has to be stable. Number is a stable type, but types like objects are generally not stable types, but there is a way to work with making objects stable. 

This CodeLab shows how to make both stable types and types like objects stable, so data is persistence and survive canister code upgrades.

## Stable Types
Duration: 0:05:00

The CodeLab "Minimalistic Motoko Dapp" is a good example of a simple Dapp, where the stable variable can be implemented. As the Dapp is, the counter variable will be reset when the canister code is upgraded. 

This behaviour may be acceptable in a Dapp like this, but if the data is more sensitive and must be retained, let's say the Dapp is logging the value and wants it to persist, we need to make the variable stable. 

The "Minimalistic Motoko Dapp" Motoko code looks like this:

```javascript
actor {
    
    var counter : Nat = 0;

    public func increment() : async Nat {
        counter += 1;
        return counter;
    };

    public query func get() : async Nat {
        return counter;
    };
    
    public func reset() : async Nat {
        counter := 0;
        return counter;
    };
};
```

### Make counter stable
In this example the variable is a stable type, which means it's predictable what the type will be - in this case the variable is number. Therefore making the variable is easy, `stable` is just added to the variable declaration:

```javascript
stable var counter : Nat = 0;
```
Now the counter value will persist, and not be reset if the canister code is upgraded.

## Non-Stable Types
Duration: 0:05:00

As mentioned in the introduction, persistence of the data requires stable data types. Types like objects are generally not stable, but there is a need to have stable objects. Think about user accounts, historical data with timestamps etc. 

The way these types are made stable is, to copy non-stable data to a stable variable right before the canister code is upgraded, and once the upgrade has been completed, the non-stable data is loaded back into the non-stable variable. 

### Preupgrade and Postupgrade
Copying the non-stable data to and from the stable variable is made easy by using system hooks, which will be triggered pre and post upgrades. 

```javascript
system func preupgrade() { };

system func postupgrade() { };
```

The `preupgrade` method can make final updated before the runtime commits values to the Internet Computer's stable memory before the canister upgrade. The `postupgrade` method runs after the upgrade has been completed, and after the stable variables have been populated.  

### Code Example

To demonstrate how this works, let's look at a code example:

```javascript
actor Registry {

  stable var entries : [(Text, Nat)] = [];

  let map = Map.fromIter<Text,Nat>(
    entries.vals(), 10, Text.equal, Text.hash);

  public func register(name : Text) : async () {
    switch (map.get(name)) {
      case null  {
        map.put(name, map.size());
      };
      case (?id) { };
    }
  };

  public func lookup(name : Text) : async ?Nat {
    map.get(name);
  };

  system func preupgrade() {
    entries := Iter.toArray(map.entries());
  };

  system func postupgrade() {
    entries := [];
  };
}
```

The code has two public functions, which can register a name and an ID, and lookup stored registered names. Think of this as a simple user registry. 

First the stable variable, in this case an array, is defined. This is the variable we are using to hold the non-stable data during the upgrade.

```javascript
stable var entries : [(Text, Nat)] = [];
```

The registered names and IDs are stored in the `map` variable, and the default values are loaded from the `entries` when it's being declared. If `entries` is empty, `map` will also be empty.

```javascript
let map = Map.fromIter<Text,Nat>(
  entries.vals(), 10, Text.equal, Text.hash);
```

The `entries` stable variable is populated with the `map` data right before the upgrade using the `preupgrade` method, to ensure the data is current. 

```javascript
system func preupgrade() {
  entries := Iter.toArray(map.entries());
};
```

The `postupgrade` method can be used to clear the `entries` array so it's not holding stale data next time the canister code is upgraded

```javascript
system func postupgrade() {
  entries := [];
};
```

## Summary
Duration: 0:01:00

The stable variable storage makes it safe to store Dapp data in the canister, and `preupgrade` and `postupgrade` in Motoko provides system methods to retain data in the canister, but it's up to you as a developer how you wish to implement data storage and data persistence. 
