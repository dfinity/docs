import type { Principal } from '@dfinity/principal';
export type Owner = Principal;
export type Owner__1 = Principal;
export type TokenIndex = number;
export type TransferResponse = { 'ok' : [] | [Owner__1] } |
  { 'err' : { 'InvalidToken' : Owner__1 } };
export interface _SERVICE {
  'mintNFT' : (
      arg_0: Owner,
      arg_1: string,
      arg_2: string,
      arg_3: string,
    ) => Promise<TokenIndex>,
  'ownerOf' : (arg_0: TokenIndex) => Promise<[] | [Owner]>,
  'transfer' : (arg_0: Owner, arg_1: Owner, arg_2: TokenIndex) => Promise<
      TransferResponse
    >,
}
