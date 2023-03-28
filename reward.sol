// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/utils/math/SafeMath.sol";

import "@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";
import "@openzeppelin/contracts-upgradeable/proxy/utils/UUPSUpgradeable.sol";


contract Staking is Initializable, OwnableUpgradeable, UUPSUpgradeable {
    ///////////////////// Variables ///////////////////////
    using SafeMath for uint256;

    struct UserInfo {
        uint256 amount;
        uint256 rewardAmount;
        uint256 investmentTime;
        uint256 rewardWithdrawTime;
    }

    struct TxHistory{
        uint256 txAmount;
        uint256 txTime;
        string txType;
    }

    // Precision factor for calculating rewards
    uint256 public constant PRECISION_FACTOR = 10**12;

    address public OGBTokenAddress;

    // Block number when rewards start
    uint256 public START_BLOCK;

    // Accumulated tokens per share
    uint256 public accTokenPerShare;

    // Current phase for rewards
    uint256 public currentPhase;

    // Block number when rewards end
    uint256 public endBlock;

    // Block number of the last update
    uint256 public lastRewardBlock;

    // Tokens distributed per block for staking
    uint256 public rewardPerBlockForStaking;

    // Total amount staked
    uint256 public totalAmountStaked;

    // Total number of stakers
    uint256 public stakerCount;

    mapping(address => UserInfo) public userInfo;
    mapping(address => uint256) private debtRewards;
    mapping(address => TxHistory[]) private userTxsArray;
    mapping(address => bool) public isStakerExists;

    event Deposit(address indexed user, uint256 amount, uint256 harvestedAmount);
    event Withdraw(address indexed user, uint256 amount, uint256 harvestedAmount);
    
    constructor() {
        _disableInitializers();
    }

    function initialize(address _OGBTokenAddress, uint256 _startBlock, uint256 _rewardsPerBlockForStaking, uint256 _periodLengthesInBlocks) public initializer {
        __Ownable_init();
        __UUPSUpgradeable_init();
        
        OGBTokenAddress = _OGBTokenAddress;
        rewardPerBlockForStaking = _rewardsPerBlockForStaking;

        START_BLOCK = _startBlock;
        endBlock = _startBlock + _periodLengthesInBlocks;

        // Set the lastRewardBlock as the startBlock
        lastRewardBlock = _startBlock;
    }

    function _authorizeUpgrade(address newImplementation) internal override onlyOwner {}

    function deposit(uint256 amount) external {
        require(block.number <= endBlock, "stake time is out");
        require(amount > 0, "Deposit: Amount must be > 0");
        _updatePool();

        IERC20(OGBTokenAddress).transferFrom(msg.sender, address(this), amount);

        uint256 pendingRewards;

        userInfo[msg.sender].amount += amount;

        userInfo[msg.sender].investmentTime = block.timestamp;

        if(!isStakerExists[msg.sender]){
            isStakerExists[msg.sender] = true;
            stakerCount++;
        }

        debtRewards[msg.sender] = (userInfo[msg.sender].amount * accTokenPerShare) / PRECISION_FACTOR;

        totalAmountStaked += (amount);

        TxHistory memory txH = TxHistory(amount, block.timestamp, "Stake");
        userTxsArray[msg.sender].push(txH);
        emit Deposit(msg.sender, amount, pendingRewards);
    }

    function getUserInfo(address _userAddress) public view returns(UserInfo memory _userInfo){
        _userInfo.amount = userInfo[_userAddress].amount;
        (_userInfo.rewardAmount,) = calculatePendingRewards(_userAddress);
        _userInfo.investmentTime = userInfo[_userAddress].investmentTime;
        _userInfo.rewardWithdrawTime = userInfo[_userAddress].rewardWithdrawTime;
    }

    function withdrawAll() external {
        require(userInfo[msg.sender].amount > 0, "Withdraw: Amount must be > 0");

        // Update pool
        _updatePool();

        // Calculate pending rewards and amount to transfer (to the sender)
        uint256 pendingRewards = ((userInfo[msg.sender].amount * accTokenPerShare) / PRECISION_FACTOR) - debtRewards[msg.sender];
        //console.log("pendingRewards", pendingRewards);
        uint256 amountToTransfer = userInfo[msg.sender].amount + pendingRewards;
        //console.log("amountToTransfer", amountToTransfer);
        // Adjust total amount staked
        totalAmountStaked = totalAmountStaked - userInfo[msg.sender].amount;
        //console.log("totalAmountStaked", totalAmountStaked);

        // Adjust user information
        userInfo[msg.sender].amount = 0;
        debtRewards[msg.sender] = 0;

        // Transfer LOOKS tokens to the sender
        IERC20(OGBTokenAddress).transfer(msg.sender, amountToTransfer);
        totalAmountStaked -= userInfo[msg.sender].amount;

        userInfo[msg.sender].rewardWithdrawTime = block.timestamp;

        TxHistory memory txH = TxHistory(amountToTransfer, block.timestamp, "Withdraw");
        userTxsArray[msg.sender].push(txH);
        emit Withdraw(msg.sender, amountToTransfer, pendingRewards);
    }

    function calculatePendingRewards(address user) public view returns (uint256, uint256) {
        uint256 multiplier;
        if ((block.number > lastRewardBlock) && (totalAmountStaked != 0)) {
            multiplier = _getMultiplier(lastRewardBlock, block.number);
            //console.log("multiplier", multiplier);

            uint256 tokenRewardForStaking = multiplier * rewardPerBlockForStaking;
            //console.log("tokenRewardForStaking", tokenRewardForStaking);

            uint256 adjustedTokenPerShare = accTokenPerShare + (tokenRewardForStaking * PRECISION_FACTOR) / totalAmountStaked;
            //console.log("adjustedTokenPerShare", adjustedTokenPerShare);

            // console.log("userInfo[user].amount", userInfo[user].amount);
            // console.log("debtRewards[msg.sender]", debtRewards[msg.sender]);
            //return (userInfo[user].amount * adjustedTokenPerShare) / PRECISION_FACTOR - debtRewards[msg.sender];
            return ((userInfo[user].amount * adjustedTokenPerShare) / PRECISION_FACTOR - debtRewards[msg.sender], multiplier);
        } else {
            // console.log("in");
            //return (userInfo[user].amount * accTokenPerShare) / PRECISION_FACTOR - debtRewards[msg.sender];
            return ((userInfo[user].amount * accTokenPerShare) / PRECISION_FACTOR - debtRewards[msg.sender], multiplier);
        }
    }

    function _updatePool() internal {
        if (block.number <= lastRewardBlock) {
            return;
        }
        if (totalAmountStaked == 0) {
            lastRewardBlock = block.number;
            return;
        }
        uint256 multiplier = _getMultiplier(lastRewardBlock, block.number);
        uint256 tokenRewardForStaking = multiplier * rewardPerBlockForStaking;

        if (tokenRewardForStaking > 0) {
            accTokenPerShare = accTokenPerShare + ((tokenRewardForStaking * PRECISION_FACTOR) / totalAmountStaked);
        }

        // Update last reward block only if it wasn't updated after or at the end block
        if (lastRewardBlock <= endBlock) {
            lastRewardBlock = block.number;
        }
    }

    function _getMultiplier(uint256 from, uint256 to) public view returns (uint256) {
        if (to <= endBlock) {
            return to - from;
        } else if (from >= endBlock) {
            return 0;
        } else {
            return endBlock - from;
        }
    }

    function getRemainingBlocks() public view returns(uint256 _blocks){
        if(START_BLOCK <= block.number)
        _blocks = endBlock - block.number;
        else
        _blocks = 0;
    }

    function getTokenBalance(address _tokenAddress) public view returns(uint256 _tokenAmount){
        _tokenAmount = IERC20(_tokenAddress).balanceOf(address(this));
    }

    function getUserTransactions(uint256 page , uint256 size, address user) public view returns(TxHistory[] memory){
        uint256 ToSkip = page*size;  //to skip
        uint256 count = 0 ; 
        TxHistory[] memory txsArray = userTxsArray[user];
        uint256 EndAt= txsArray.length > ToSkip + size? ToSkip + size: txsArray.length;

        require(ToSkip < txsArray.length, "OVERFLOW_PAGE");
        require(EndAt > ToSkip, "OVERFLOW_PAGE");

        TxHistory[] memory tokensArray = new TxHistory[](EndAt - ToSkip);
        for (uint256 i = ToSkip ; i < EndAt; i++) {
            tokensArray[count] = txsArray[txsArray.length - 1 - i];
            count++;
        }
        return tokensArray;
    }
    
    function userTransactionsLength(address user)public view returns(uint256 _transactionsLength){
        uint256 transactionsLength = userTxsArray[user].length;
        return transactionsLength;
    }

    function setEndBLock(uint256 _endBlock) public onlyOwner{
        endBlock = _endBlock;
    }

    function startEndBLock(uint256 _startBlock) public onlyOwner{
        START_BLOCK = _startBlock;
    }

    function emergencyWithdrawToken(address token, address destination) public onlyOwner returns (bool sent){
        IERC20(token).transfer(destination, IERC20(token).balanceOf(address(this)));
        return true;
    }

    function emergencyWithdrawCurrency(address destination) public onlyOwner returns (bool sent) {
        require(address(this).balance != 0, "ZERO_BALANCE");
        payable(destination).transfer(address(this).balance);
        return true;
    }

    receive() external payable {}

    fallback() external payable {}
}
