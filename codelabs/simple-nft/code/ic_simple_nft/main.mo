import Cycles "mo:base/ExperimentalCycles";
import HashMap "mo:base/HashMap";
import Hash "mo:base/Hash";
import Principal "mo:base/Principal";
import Result "mo:base/Result";
import Iter "mo:base/Iter";
import Random "mo:base/Random";
import Text "mo:base/Text";
import Nat "mo:base/Nat";
import Nat8 "mo:base/Nat8";
import Nat32 "mo:base/Nat32";
import Debug "mo:base/Debug";
import Types "./types"

actor {

    type User = Types.User;
    type TokenIndex  = Types.TokenIndex ;
    type Metadata = Types.Metadata;
    type Property = Types.Property;
    type Properties = Types.Properties;
    type Owner = Types.Owner;
    type CommonError = Types.CommonError;
    type TransferResponse = Types.TransferResponse;

    private stable var _nextTokenId : TokenIndex  = 0;

    private stable var _registryState : [(TokenIndex, Owner)] = [];
    private var _registry : HashMap.HashMap<TokenIndex, Owner> = HashMap.fromIter(_registryState.vals(), 0, Core.TokenIndex.equal, Core.TokenIndex.hash);
    
    private stable var _tokenState : [(TokenIndex, Metadata)] = [];
    private var _token : HashMap.HashMap<TokenIndex, Metadata> = HashMap.fromIter(_tokenState.vals(), 0, Core.TokenIndex.equal, Core.TokenIndex.hash);


    //State functions
    system func preupgrade() {
        _registryState := Iter.toArray(_registry.entries());
        _tokenState := Iter.toArray(_token.entries());
    };
    system func postupgrade() {
        _registryState := [];
        _tokenState := [];
    };

    public func ownerOf(tokenId : TokenIndex) : async ?Owner {  

        let owner = _registry.get(tokenId);
        return owner;
    }; 



    public func transfer(from: Owner, to: Owner, tokenId: TokenIndex) : async TransferResponse {

        switch (_registry.get(tokenId)) {
            case (?token_owner) {
                if(Principal.equal(from, to)) {
                    return #err(#InvalidToken(to));
                };

                let prev = _registry.replace(tokenId, to);
                return #ok(?to);
            };
            case (_) {
                return #err(#InvalidToken(to));
            };
        };
    }; 


    public func mintNFT(to: Owner, name: Text, description: Text, tokenURI: Text) : async TokenIndex { // TokenIndex {

        let tokenId = _nextTokenId;

        let _name : Properties = {
            kind = "string";
            description =  name;
        };

        let _description : Properties = {
            kind = "string";
            description = description;
        };

        let _image : Properties = {
            kind = "string";
            description =  tokenURI;
        };

        let _properties : Property = {
            name = _name;
            description = _description;
            image = _image;
        };

        let metadata : Metadata = {
            title       = "Asset Metadata";
            kind        = "object";
            properties  = _properties;
        };

        _token.put(tokenId, metadata);
        _registry.put(tokenId, to);
        _nextTokenId := _nextTokenId + 1;

        return tokenId;
    };
};
