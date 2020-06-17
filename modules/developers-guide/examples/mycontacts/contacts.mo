import List "mo:base/List";
import AssocList "mo:base/AssocList";

type Name = Text;
type Phone = Nat;

type Entry = {
    name: Name;
    address1: Text;
    address2: Text;
    email: Text;
    phone: Phone;
};

type ContactsMap = AssocList.AssocList<Name, Entry>;

actor {
    flexible var contact: ContactsMap = List.nil<(Name, Entry)>();

    func nameEq(lhs: Name, rhs: Name): Bool {
        return lhs == rhs;
    };

    public func insert(name0: Name, address10: Text, address20: Text, email0: Text, phone0: Phone): async () {
        let newEntry : Entry = {
            name = name0;
            address1 = address10;
            address2 = address20;
            email = email0;
            phone = phone0;
        };

        let (newContacts, _) = AssocList.replace<Name, Entry>(
            contact,
            name0,
            func(n: Name, m: Name) = n == m,
            ?newEntry
        );
        contact := newContacts;
    };

    public query func lookup(name: Name): async ?Entry {
        return AssocList.find<Name, Entry>(contact, name, nameEq);
    };
};
