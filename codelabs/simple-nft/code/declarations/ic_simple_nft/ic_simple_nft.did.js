export const idlFactory = ({ IDL }) => {
  const Owner = IDL.Principal;
  const TokenIndex = IDL.Nat32;
  const Owner__1 = IDL.Principal;
  const TransferResponse = IDL.Variant({
    'ok' : IDL.Opt(Owner__1),
    'err' : IDL.Variant({ 'InvalidToken' : Owner__1 }),
  });
  return IDL.Service({
    'mintNFT' : IDL.Func(
        [Owner, IDL.Text, IDL.Text, IDL.Text],
        [TokenIndex],
        [],
      ),
    'ownerOf' : IDL.Func([TokenIndex], [IDL.Opt(Owner)], []),
    'transfer' : IDL.Func([Owner, Owner, TokenIndex], [TransferResponse], []),
  });
};
export const init = ({ IDL }) => { return []; };
