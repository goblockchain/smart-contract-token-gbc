pragma solidity 0.4.24;

import "../zeppelin/ownership/Ownable.sol";
import "../zeppelin/token/ERC20/StandardToken.sol";
import "../zeppelin/math/SafeMath.sol";
import "../Colabs.sol";

contract GOToken is StandardToken, Colabs {
    using SafeMath for uint256;

    string public name = "Go Token";
    uint8 public decimals = 2;
    string public symbol = "GBC";
    string public version = "GBC 1.0";

    function mint(address _to, uint256 _value) public onlyOwner {
        totalSupply_ = totalSupply_.add(_value);
        balances[_to] = balances[_to].add(_value);

        emit MintEvent(_to, _value);
    }

    function destroy(address _from, uint256 _value) public onlyOwner {
        totalSupply_ = totalSupply_.sub(_value);
        balances[_from] = balances[_from].sub(_value);

        emit DestroyEvent(_from, _value);
    }

    event MintEvent(address indexed to, uint value);
    event DestroyEvent(address indexed from, uint value);
}