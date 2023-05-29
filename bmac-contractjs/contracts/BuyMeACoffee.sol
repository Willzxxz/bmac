// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

//deployed to 0x7bB5f2a881C6dF0387E4874dB797C3ead54D1b80

contract BuyMeACoffee {
   //event to emit when a memo is created
   event NewMemo( 
    address indexed from,
    uint256 timestamp,
    string name,
    string message);

   // create memo scruct 
   struct Memo {
    address from;
    uint256 timestamp;
    string name;
    string message;
   }

   //list of all memo received
   Memo[] memos;

   //address of contract deployer.
   address payable owner;

   //deploys logic
   constructor() {
      owner = payable(msg.sender);
   }

   /**
    * @dev buy me a coffee for contract owner
    * @param _name name of the coffee buyer
    * @param _message a nice message from the coffee buyer
    */
   function buyCoffee(string memory _name, string memory _message) public payable {
require(msg.value > 0, "can't buy coffee with 0 eth");

//add the memo to storage
   memos.push(Memo( 
      msg.sender,
      block.timestamp,
      _name,
      _message
   ));

   //emit a log event when event happens
   emit NewMemo(
      msg.sender,
      block.timestamp,
      _name,
      _message
   );
   }

   // @dev send the entire balance stored in this contract to the owner
   
   function withdrawTips() public {
      address(this).balance;
      require(owner.send(address(this).balance));
   }

   // @dev retrieve all the memos and stored on the blockchain

   function getMemos() public view returns(Memo[] memory){
      return memos;
   }
} 
