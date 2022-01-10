# Simple NFT Demo

## Intro
This CodeLab shows a very simple implementation of NFT minting. The project does not include functionality for payment transactions or an UI, but the functionality can be tested through the Candid interface.<br><br>The project has the following functionality:

- Minting a NFT
- Transfer ownership
- Checking ownership of a NFT

Other features like payment, approvals and file uploads will be covered in future CodeLabs, as an extension of this project.

## Before you begin
Before you start this tutorial, verify the following:
* You have an internet connection and access to a shell terminal on your local macOS or Linux computer.
* You have node.js installed if you want to include the default template files for front-end development in your project.
* You have downloaded and installed the DFINITY Canister SDK package as described in Download and install.
* You have installed the Visual Studio Code plugin for Motoko as described in Install the language editor plug-in if you are using Visual Studio Code as your IDE.
* You have stopped any Internet Computer network processes running on the local computer.

## NFT Metadata
This project is *inspired* by the ERC721 token standard, and the standard's metadata format is being used. The functions are not strictly following the ERC721 standard.

### Metadata format
```
{
    "title": "Asset Metadata",
    "type": "object",
    "properties": {
        "name": {
            "type": "string",
            "description": "Identifies the asset to which this NFT represents"
        },
        "description": {
            "type": "string",
            "description": "Describes the asset to which this NFT represents"
        },
        "image": {
            "type": "string",
            "description": "A URI pointing to a resource with mime type image/* representing the asset to which this NFT represents. Consider making any images at a width between 320 and 1080 pixels and aspect ratio between 1.91:1 and 4:5 inclusive."
        }
    }
}
```

For more information about the ERC721 standard [see here](https://eips.ethereum.org/EIPS/eip-721)


## Mint NFT
In this simplified NFT dapp uploading an image, and filling out name and description in a form in an UI, is not covered. Instead it's assumed that the URL for the image is already known. 

Minting the NFT is done in two steps. First the metadata is stored with a consecutive token ID. The next step is to register the token ID with the owner ID. 

### Variables
Two HashMaps are used to store the metadata and the registry with token and owner IDs. The concurrent token ID is stored as a Nat32.

```
   private stable var _registryState : [(TokenIndex, Owner)] = [];
   private var _registry : HashMap.HashMap<TokenIndex, Owner> = HashMap.fromIter(_registryState.vals(), 0, Core.TokenIndex.equal, Core.TokenIndex.hash);

   private stable var _tokenState : [(TokenIndex, Metadata)] = [];
   private var _token : HashMap.HashMap<TokenIndex, Metadata> = HashMap.fromIter(_tokenState.vals(), 0, Core.TokenIndex.equal, Core.TokenIndex.hash);

   private stable var _nextTokenId : TokenIndex  = 0;
```

### Metadata
The metadata is defined as described in the previous step, following the ERC721 token standard, and it's implemented like this:
```
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
```
### Minting function
The function will take the parameter `to`, which is the owner of the NFT, and the metadata parameters `name`, `description` and `tokenURI`. 

First the metadata variable is populated with the parameter values, and then the metadata is stored in the token HashMap with the next token ID as the key and the metadata as the value. 

After storing the token metadata, the relationship between the owner and the token is stored in the registry HashMap, with the token ID as the key and the owner ID as the value. Finally the concurrent token ID is incremented.
```
public func mintNFT(to: Owner, name: Text, description: Text, tokenURI: Text) : async TokenIndex {

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
      title = "Asset Metadata";
      kind = "object";
      properties = _properties;
   };

   _token.put(tokenId, metadata);
   _registry.put(tokenId, to);
   _nextTokenId := _nextTokenId + 1;

   return tokenId;
};
```    
The token ID will be returned on success.

### Test Minting
Deploy the project with `dfx deploy` (locally) and use dfx canister call to test the function:
```
dfx canister call ic_simple_nft mintNFT '(principal "xxxxx-...-xxx", "My NFT", "My first NFT", "http://link-to-nft.com/img.gif")'
```

## Transfer NFT
Once created, the NFT's ownership can be transferred to a new owner. The `transfer()` function takes the three parameters `from`, `to` and `tokenId` and will register the `to` owner as the new owner of the NFT.
```
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
```
First the function checks if the NFT's token ID exists in the registry. If it does, and if `from` and `to` are not the same, the registry is updated, and the NFT has transferred the NFT to a different owner.

### Test Transfer
Deploy the project with `dfx deploy` (locally) and use dfx canister call to test the function:
```
dfx canister call ic_simple_nft transfer '(principal "xxxxx-...-xxx", principal "yyyyy-...-yyy", 20)'
```

## Owner of NFT
The function `ownerOf` simply looks up the owner of a given NFT. This can be useful in many ways and in this small sample project the function can be used to verify a transfer was successfully.
```
public func ownerOf(tokenId : TokenIndex) : async ?Owner {   

   let owner = _registry.get(tokenId);

   return owner;
}; 
```

### Test Transfer
Deploy the project with `dfx deploy` (locally) and use dfx canister call to test the function:
```
dfx canister call ic_simple_nft ownerOf 20
```

## Get the code
The full code for the project in this CodeLab can be found [here](https://github.com/carstenjacobsen/ic_simple_nft)






