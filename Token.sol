//SPDX-License-Identifier: UNLICENSED

pragma solidity >=0.5.0 <0.9.0; 

interface ERC20Interface{

function totalSupply() external view returns (uint);
function balanceOf(address _owner) external  view returns (uint balance);
function transfer(address _to, uint _value) external returns (bool success);
function transferFrom(address _from, address _to, uint _value) external returns (bool success);
function approve(address _spender, uint _value) external returns (bool success);
function allowance(address _owner, address _spender) external view returns (uint remaining);

event Transfer(address indexed _from, address indexed _to, uint _value);
event Approval(address indexed _owner, address indexed _spender, uint _value);

} 

contract Block is ERC20Interface{
   string public name="vaibhav";
   string public symbol="vbhv";
   string public decimal="0";

   uint public override totalSupply;
   address public founder;
   mapping(address=>uint) public balances;
   mapping(address=>mapping(address=>uint)) allowed ;

   constructor(){
       totalSupply=10000;
       founder=msg.sender;
       balances[founder]=totalSupply;


   }
   function balanceOf(address tokenowner) public view override returns(uint balance){
       return balances[tokenowner];

   }
   function transfer(address to, uint tokens) public override returns(bool success){
     require(balances[msg.sender]>=tokens);
     balances[to]+=tokens;
     balances[msg.sender]-=tokens;
     emit Transfer(msg.sender,to,tokens);
     return true;

   }
   function approve(address spender, uint tokens) public override returns(bool success){
       require(balances[msg.sender]>=tokens);
       require(tokens>0);
       allowed[msg.sender][spender]=tokens;
       emit Approval(msg.sender,spender,tokens);
       return true;
       


   }
   function allowance(address tokenowner, address spender) public view override returns( uint nooftokens){
       return allowed[tokenowner][spender];                                         
   }
   function transferFrom(address from, address to,uint tokens) public  override returns(bool success){
    require(allowed[from][to]>=tokens);
    require(balances[from]>=tokens);
    balances[from]-=tokens;
    balances[to]+=tokens;
    return true;


   }

}
