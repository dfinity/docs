/**
 * Module      : Hex.mo
 * Description : Hexadecimal encoding and decoding routines.
 * Copyright   : 2020 Enzo Haussecker
 * License     : Apache 2.0 with LLVM Exception
 * Maintainer  : Enzo Haussecker <enzo@dfinity.org>
 * Stability   : Stable
 */

import Array "mo:base/Array";
import Iter "mo:base/Iter";
import Option "mo:base/Option";
import Prim "mo:prim";
import Result "mo:base/Result";

module {

  private type Result<Ok, Err> = Result.Result<Ok, Err>;

  private let base : Word8 = 0x10;

  private let symbols = [
    '0', '1', '2', '3', '4', '5', '6', '7',
    '8', '9', 'A', 'B', 'C', 'D', 'E', 'F',
  ];

  /**
   * Define a type to indicate that the decoder has failed.
   */
  public type DecodeError = {
    #msg : Text;
  };

  /**
   * Encode an array of unsigned 8-bit integers in hexadecimal format.
   */
  public func encode(array : [Word8]) : Text {
    Array.foldLeft<Word8, Text>(array, "", func (accum, w8) {
      accum # encodeW8(w8);
    });
  };

  /**
   * Encode an unsigned 8-bit integer in hexadecimal format.
   */
  private func encodeW8(w8 : Word8) : Text {
    let c1 = symbols[Prim.word8ToNat(w8 / base)];
    let c2 = symbols[Prim.word8ToNat(w8 % base)];
    Prim.charToText(c1) # Prim.charToText(c2);
  };

  /**
   * Decode an array of unsigned 8-bit integers in hexadecimal format.
   */
  public func decode(text : Text) : Result<[Word8], DecodeError> {
    let next = text.chars().next;
    func parse() : Result<Word8, DecodeError> {
      Option.get<Result<Word8, DecodeError>>(
        Option.chain<Char, Result<Word8, DecodeError>>(next(), func (c1) {
          Option.chain<Char, Result<Word8, DecodeError>>(next(), func (c2) {?
            Result.chain<Word8, Word8, DecodeError>(decodeW4(c1), func (x1) {
              Result.chain<Word8, Word8, DecodeError>(decodeW4(c2), func (x2) {
                #ok (x1 * base + x2);
              });
            });
          });
        }),
        #err (#msg "Not enough input!"),
      );
    };
    var i = 0;
    let n = text.size() / 2 + text.size() % 2;
    let array = Array.init<Word8>(n, 0);
    while (i != n) {
      switch (parse()) {
        case (#ok w8) {
          array[i] := w8;
          i += 1;
        };
        case (#err err) {
          return #err err;
        };
      };
    };
    #ok (Array.freeze<Word8>(array));
  };

  /**
   * Decode an unsigned 4-bit integer in hexadecimal format.
   */
  private func decodeW4(char : Char) : Result<Word8, DecodeError> {
    for (i in Iter.range(0, 15)) {
      if (symbols[i] == char) {
        return #ok (Prim.natToWord8(i));
      };
    };
    let str = "Unexpected character: " # Prim.charToText(char);
    #err (#msg str);
  };
};