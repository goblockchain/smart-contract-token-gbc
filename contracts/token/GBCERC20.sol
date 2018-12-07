pragma solidity 0.4.24;

import "../zeppelin/token/ERC20/ERC20Detailed.sol";
import "../zeppelin/token/ERC20/ERC20Mintable.sol";

contract GBCERC20 is ERC20Detailed("GOBlockchain Coin", "GBC", 18), ERC20Mintable {

}