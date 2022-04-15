// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

/** 
 * @title Subscription
 * @dev Implements the subscription process
 */
contract Subscription {
   
    struct Subscriber {
        string username; // nickname of subscriber
        // address addr; // address of subscriber
        string expiryDate;   // expiry date of current subscription
        bool exists; // whether the subscriber exists
    }

    // struct Plan {
    //     bytes32 name;   // subscription plan title (up to 32 bytes)
    //     uint duration; // length of subscription
    //     uint cost;   // cost of the plan
    // }

    // Plan[] public plans;

    address public admin;

    mapping(address => Subscriber) public subscribers;

    /** 
     * @dev Create a new streaming service to subscribe to and declare owner as 'admin'.
     */
    constructor() {
        admin = msg.sender;
    }

    /** 
     * @dev Function to receive Ether. msg.data must be empty
     */ 
    receive() external payable {}
    
    /** 
     * @dev Retrieve 'balance' of contract
     */
    function getBalance() public view returns (uint) {
        return address(this).balance;
    }

    /** 
     * @dev Retrieve 'subscriber' info
     * @param subscriber address of subscriber
     */
    function getSubscriberInfo(address subscriber) public view returns (Subscriber memory){
        require(
            subscribers[subscriber].exists,
            "The subscriber does not exist."
        );
        return subscribers[subscriber];
    }

    /** 
     * @dev Add 'subscriber' to the list of existing users.
     * @param subscriber address of subscriber
     * @param username nickname of subscriber
     */
    function register(address subscriber, string memory username) public returns (Subscriber memory){
        require(subscribers[subscriber].exists!=true, "User already exists!");
        subscribers[subscriber].exists=true;
        subscribers[subscriber].username=username;
        // subscribers[subscriber].address=subscriber;
        return subscribers[subscriber];
    }
    
    /** 
     * @dev Allow 'subscriber' to subscribe to a plan.
     * @param amount cost of the plan.
     * @param newDate new expiry date for the subscription.
     */
    function subscribe(uint256 amount, string memory newDate) payable public {
        address subscriber = msg.sender;
        require(
            subscribers[subscriber].exists,
            "The subscriber does not exist!"
        );
        require(msg.value == amount, "Incorrect amount sent");
        subscribers[msg.sender].expiryDate = newDate;
        // address payable recipient = payable(admin);
        // recipient.transfer(amount);
    }

    /** 
     * @dev Allow anyone to deposit money to the contract.
     * @param amount amount to be deposited .
     */
    function deposit(uint256 amount) payable public {
        require(msg.value == amount);
    }

    /** 
     * @dev Allow 'admin' to withdraw money from the account.
     */
    function withdraw() public {
        require(admin==msg.sender);
        address payable recipient = payable(admin);
        recipient.transfer(address(this).balance);
    }
}
