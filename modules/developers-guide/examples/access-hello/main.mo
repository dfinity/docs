// Import base modules
import AssocList "mo:base/AssocList";
import Error "mo:base/Error";
import List "mo:base/List";

shared({ caller = initializer }) actor class() {

    // Establish role-based greetings to display
    public shared({ caller }) func greet(name : Text) : async Text {
        if (has_permission(caller, #assign_role)) {
            return "Hello, " # name # ". You have a role with administrative privileges."
        } else if (has_permission(caller, #lowest)) {
            return "Welcome, " # name # ". You have an authorized account. Would you like to play a game?";
        } else {
            return "Greetings, " # name # ". Nice to meet you!";
        }
    };

    // Define custom types
    public type Role = {
        #owner;
        #admin;
        #authorized;
    };

    public type Permission = {
        #assign_role;
        #lowest;
    };

    private stable var roles: AssocList.AssocList<Principal, Role> = List.nil();
    private stable var role_requests: AssocList.AssocList<Principal, Role> = List.nil();

    func principal_eq(a: Principal, b: Principal): Bool {
        return a == b;
    };

    func get_role(pal: Principal) : ?Role {
        if (pal == initializer) {
            ?#owner;
        } else {
            AssocList.find<Principal, Role>(roles, pal, principal_eq);
        }
    };

    // Determine if a principal has a role with permissions
    func has_permission(pal: Principal, perm : Permission) : Bool {
        let role = get_role(pal);
        switch (role, perm) {
            case (?#owner or ?#admin, _) true;
            case (?#authorized, #lowest) true;
            case (_, _) false;
        }
    };

    // Reject unauthorized user identities
    func require_permission(pal: Principal, perm: Permission) : async () {
        if ( has_permission(pal, perm) == false ) {
            throw Error.reject( "unauthorized" );
        }
    };

    // Assign a new role to a principal
    public shared({ caller }) func assign_role( assignee: Principal, new_role: ?Role ) : async () {
        await require_permission( caller, #assign_role );

        switch new_role {
            case (?#owner) {
                throw Error.reject( "Cannot assign anyone to be the owner" );
            };
            case (_) {};
        };
        if (assignee == initializer) {
            throw Error.reject( "Cannot assign a role to the canister owner" );
        };
        roles := AssocList.replace<Principal, Role>(roles, assignee, principal_eq, new_role).0;
        role_requests := AssocList.replace<Principal, Role>(role_requests, assignee, principal_eq, null).0;
    };

    public shared({ caller }) func request_role( role: Role ) : async Principal {
        role_requests := AssocList.replace<Principal, Role>(role_requests, caller, principal_eq, ?role).0;
        return caller;
    };

    // Return the principal of the message caller/user identity
    public shared({ caller }) func callerPrincipal() : async Principal {
        return caller;
    };

    // Return the role of the message caller/user identity
    public shared({ caller }) func my_role() : async ?Role {
        return get_role(caller);
    };

    public shared({ caller }) func my_role_request() : async ?Role {
        AssocList.find<Principal, Role>(role_requests, caller, principal_eq);
    };

    public shared({ caller }) func get_role_requests() : async List.List<(Principal,Role)> {
        await require_permission( caller, #assign_role );
        return role_requests;
    };

    public shared({ caller }) func get_roles() : async List.List<(Principal,Role)> {
        await require_permission( caller, #assign_role );
        return roles;
    };
};
