pragma solidity ^0.4.23;

import "./zeppelin/ownership/Ownable.sol";
import "./zeppelin/ownership/rbac/RBAC.sol";

contract Collaborator is Ownable, RBAC {
    
    /**
    * A constant role name for indicating admins.
    */
    string public constant ROLE_ADMIN = "admin";
    string public constant ROLE_ADVISOR = "advisor";
    string public constant ROLE_ESPECIALIST = "especialist";
    string public constant ROLE_AMBASSADOR = "ambassador";
    string public constant ROLE_COLLABORATOR = "collaborator";

    /**
    * @dev constructor. Sets msg.sender as admin by default
    */
    constructor(address[] _advisors) public
    {
        addRole(msg.sender, ROLE_ADMIN);
        addRole(msg.sender, ROLE_ADVISOR);

        for (uint256 i = 0; i < _advisors.length; i++) {
            addRole(_advisors[i], ROLE_ADVISOR);
        }        
    }

    /**
    * @dev modifier to scope access to admins
    * // reverts
    */
    modifier onlyAdmin()
    {
        checkRole(msg.sender, ROLE_ADMIN);
        _;
    }

    modifier onlyAdminOrAdvisor()
    {
        require(
            hasRole(msg.sender, ROLE_ADMIN) ||
            hasRole(msg.sender, ROLE_ADVISOR)
        );
        _;
    }

    modifier onlyAdminEspecialistOrAdvisor()
    {
        require(
            hasRole(msg.sender, ROLE_ADMIN) ||
            hasRole(msg.sender, ROLE_ADVISOR) ||
            hasRole(msg.sender, ROLE_ESPECIALIST)
        );
        _;
    }

    modifier onlyEverybody()
    {
        require(
            hasRole(msg.sender, ROLE_ADMIN) ||
            hasRole(msg.sender, ROLE_ADVISOR) ||
            hasRole(msg.sender, ROLE_ESPECIALIST) || 
            hasRole(msg.sender, ROLE_AMBASSADOR) || 
            hasRole(msg.sender, ROLE_COLLABORATOR)
        );
        _;
    }    

    /**
    * @dev add a collaborator
    **/
    function addCollaborator() internal {
        addRole(_advisors[i], ROLE_COLLABORATOR);
    }

    /**
    * @dev remove a role from an address
    * @param addr address
    * @param roleName the name of the role
    */
    function adminRemoveRole(address addr, string roleName) onlyAdminOrAdvisor
        public
    {
        removeRole(addr, roleName);
    }

    // admins can remove advisor's role
    function removeAdvisor(address _addr) onlyAdmin  public {
        // revert if the user isn't an advisor
        //  (perhaps you want to soft-fail here instead?)
        checkRole(_addr, ROLE_ADVISOR);
        // remove the advisor's role
        removeRole(_addr, ROLE_ADVISOR);
    }

    /**
    * @dev Allows the current superuser to transfer his role to a newSuperuser.
    * @param _newSuperuser The address to transfer ownership to.
    */
    function transferAdmin(address _newSuperuser) onlyAdmin public
    {
        require(_newSuperuser != address(0));
        removeRole(msg.sender, ROLE_ADMIN);
        addRole(_newSuperuser, ROLE_ADMIN);
    }

}

contract TermsAndCondition is Collaborator {
    string public hash;
    event TermsAndConditionChanged(address sender, uint256 time);

    function setTermsAndCondition(string _hash) public onlyAdminOrAdvisor {
        hash = _hash;
        emit TermsAndConditionChanged(msg.sender, now);
    }
    function getHash() public view returns(string) {
        return hash;
    }
}

contract PersonIdentity is TermsAndCondition {

    enum Status {PENDING, APPROVE, REJECTED}
    Status status;
    mapping (address=>Person) public mapPerson;
    Person[] public person;
    struct Person {
        address sender;
        string name;
        string profileLinkedin;
        Status status;
        string hashTerms;
    }

    function requestApprove(string _name, string _hashTerms, string _profileLinkedin) external {
        require(mapPersonValid[msg.sender] == 0x0);
        Person memory p = Person ({
            sender: msg.sender,
            name: _name,
            profileLinkedin: _profileLinkedin,
            status: Status.PENDING,
            hashTerms: _hashTerms
        });
        person.push(p);
        mapPerson[msg.sender] = p;
    }
    
    function validate(int32 _addressToApprove, bool approveOrDisapprove) external onlyAdminOrAdvisor {
        Person p = person[_addressToApprove];
        mapPersonValid[p.sender].isValid = approveOrDisapprove;
        if (approveOrDisapprove) {

        }
    }
}