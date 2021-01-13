pragma solidity ^1.5.0;

contract Booking {
    address[8] public Bookers;

    function Reserve(uint CarID) public returns (uint) {
        require(CarID >= 0 && CarID <=7);
        Bookers[CarID] = msg.sender;
        return CarID;
    }

    function getBookers() public view returns (address[8] memory) {
        return Bookers;
    }
}