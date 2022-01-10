import Hash "mo:base/Hash";
import Nat32 "mo:base/Nat32";
import Result "mo:base/Result";

module {

    public type TokenIndex = Nat32;
    public type AccountIdentifier = Text;
    public type Owner = Principal;


    public type User = {
        address : Text; //No notification
        prcpl : Principal; //defaults to sub account 0
    };

    public type CommonError = {
        #InvalidToken: ?Owner;
        #Other : Text;
    };

    public type TransferResponse = Result.Result<?Owner, {
    //#Unauthorized: AccountIdentifier;
    //#InsufficientBalance;
    //#Rejected; //Rejected by canister
    #InvalidToken: Owner;
    //#CannotNotify: AccountIdentifier;
    //#Other : Text;
  }>;


    public module TokenIndex = {
        public func equal(x : TokenIndex, y : TokenIndex) : Bool {
            return Nat32.equal(x, y);
        };
        public func hash(x : TokenIndex) : Hash.Hash {
            return x;
        };
    };

    public type Properties = {
        kind        : Text;
        description : Text;
    };

    public type Property = {
        name        : Properties;
        description : Properties;
        image       : Properties;
    };

    public type Metadata = {
        title       : Text;
        kind        : Text;
        properties  : Property;
    };

};


