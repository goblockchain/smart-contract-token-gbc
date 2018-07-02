pragma solidity 0.4.24;

import "./TermsAndCondition.sol";

contract PersonIdentity is TermsAndCondition {

    enum Status {PENDING, APPROVE, REJECTED}
    Status status;
    mapping (address=>Person) public mapPerson;
    Person[] public person;
    event PersonValidate(bool isValid, address validator);

    struct Person {
        address sender;
        string name;
        string profileLinkedin;
        Status status;
        string hashTerms;
    }

    function requestApprove(string _name, string _hashTerms, string _profileLinkedin) external {
        require(mapPerson[msg.sender].sender == 0x0);
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
    
    function validate(address _addressToApprove, bool approveOrDisapprove) external onlyAdminOrAdvisor {
        require(mapPerson[msg.sender].sender == _addressToApprove);
        mapPerson[_addressToApprove].status = Status.APPROVE;
        if (approveOrDisapprove) {
            addCollaborator(_addressToApprove);
        }
        emit PersonValidate(approveOrDisapprove, msg.sender);
    }
}