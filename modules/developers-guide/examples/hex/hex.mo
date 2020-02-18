/**
 * Module      : hex.mo
 * Description : Hexadecimal encoding and decoding routines.
 * Copyright   : 2019 Enzo Haussecker
 * License     : Apache 2.0
 * Maintainer  : Enzo Haussecker <enzo@dfinity.org>
 * Stability   : Experimental
 */

import List "mo:stdlib/list";
import Option "mo:stdlib/option";
import Prelude "mo:stdlib/prelude";
import Result "mo:stdlib/result";

type List<T> = List.List<T>;
type Result<Ok, Err> = Result.Result<Ok, Err>;

module Hex {

  /**
   * Define a type to indicate that the decoder has failed.
   */
  public type DecodeError = {
    #msg : Text;
  };

  /**
   * Encode a list of unsigned 8-bit integers in hexadecimal format.
   */
  public func encode(list : List<Word8>) : Text {
    List.foldLeft<Word8, Text>(list, "", func (w8, accum) {
      accum # encodeWord8(w8)
    })
  };

  /**
   * Decode a list of unsigned 8-bit integers in hexadecimal format.
   */
  public func decode(text : Text) : Result<List<Word8>, DecodeError> {

    let get : () -> ?Char = text.chars().next;
    func parse() : Result<Word8, DecodeError> {
      Option.option<Text, Result<Word8, DecodeError>>(
        Option.bind<Char, Text>(get(), func (c1) {
          Option.bind<Char, Text>(get(), func (c2) {
            ?(charToText(c1) # charToText(c2))
          })
        }),
        decodeWord8,
        #err (#msg "Not enough input!")
      )
    };

    let n : Nat = text.len() / 2 + text.len() % 2;
    var accum = List.nil<Word8>();
    for (_ in range(1, n)) {
      switch (parse()) {
        case (#ok w8) {
          accum := List.push<Word8>(w8, accum);
        };
        case (#err err) {
          return #err err
        }
      }
    };

    #ok (List.rev<Word8>(accum))

  };

  /**
   * Encode an unsigned 8-bit integer in hexadecimal format.
   */
  func encodeWord8(w8 : Word8) : Text {

    func encodeWord4(w4 : Word8) : Char {
      if (w4 > (0x0F : Word8)) {
        Prelude.unreachable()
      };
      let arr : [Char] =
        [ '0', '1', '2', '3', '4', '5', '6', '7'
        , '8', '9', 'A', 'B', 'C', 'D', 'E', 'F'
        ];
      arr[word8ToNat(w4)]
    };

    let n : Word8 = 0x10;
    let c1 : Char = encodeWord4(w8 / n);
    let c2 : Char = encodeWord4(w8 % n);

    charToText(c1) # charToText(c2)

  };

  /**
   * Decode an unsigned 8-bit integer in hexadecimal format.
   */
  func decodeWord8(text : Text) : Result<Word8, DecodeError> {

    func decodeWord4(char : Char) : Result<Word8, DecodeError> {
      Result.mapOk<Nat, Word8, DecodeError>(
        switch char {
          case ('0') { #ok 00 };
          case ('1') { #ok 01 };
          case ('2') { #ok 02 };
          case ('3') { #ok 03 };
          case ('4') { #ok 04 };
          case ('5') { #ok 05 };
          case ('6') { #ok 06 };
          case ('7') { #ok 07 };
          case ('8') { #ok 08 };
          case ('9') { #ok 09 };
          case ('A') { #ok 10 };
          case ('B') { #ok 11 };
          case ('C') { #ok 12 };
          case ('D') { #ok 13 };
          case ('E') { #ok 14 };
          case ('F') { #ok 15 };
          case _ {
            #err (#msg "Unexpected character!")
          }
        },
        natToWord8
      )
    };

    let get : () -> ?Char = text.chars().next;
    func parse() : Result<Word8, DecodeError> {
      Option.option<Char, Result<Word8, DecodeError>>(
        get(),
        decodeWord4,
        #err (#msg "Not enough input!")
      )
    };

    Result.bind<Word8, Word8, DecodeError>(parse(), func (x1) {
      Result.bind<Word8, Word8, DecodeError>(parse(), func (x2) {
        #ok (x1 * 16 + x2 : Word8);
      })
    })

  }

}
