// SPDX-License-Identifier: MIT

pragma solidity ^0.8.17;

contract SendingEther {

    function sendViaTransfer(address payable _to) public payable {
        _to.transfer(msg.value);
    }

    function sendViaSend(address payable _to) public payable {
        bool sent = _to.send(msg.value);
        require(sent,"Failed to send ether");
    }
    //En çok kullanılan yöntem bu  3. yoldur.
    function sendViaCall(address payable _to) public payable {
       (bool sent, bytes memory data) =  _to.call{value: msg.value}("");
       require(sent,"Failed to send ether");    
    }
}

contract ReceiveEther {
    /*
     Which function is called, fallback() or receive()?

           send Ether
               |
         msg.data is empty?
              / \
            yes  no
            /     \
receive() exists?  fallback()
         /   \
        yes   no
        /      \
    receive()   fallback()
    
    */

    event FallbackEvent(address sender,uint256 value);

    receive() external payable {
        // msg data var fakat boş    ise buraya düşüyor.

    }

    fallback() external payable {
        //msg.data hiç yok ise buraya düşer
        //Handle incoming ether,herhangi bir data payload olmadığında fonksiyon yada o çagrıyı
        emit FallbackEvent(msg.sender, msg.value);
    }
}