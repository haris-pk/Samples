function emergencyWithdrawAll() external onlyOwner {
    uint256 totalWithdrawn;
    for (uint256 i = 0; i < boxes.length; i++) {
        for (uint256 j = 0; j < boxes[i].users.length; j++) {
            address user = boxes[i].users[j];
            uint256 amount = boxBalances[boxes[i].id][user];
            if (amount > 0) {
                totalWithdrawn += amount;
                boxBalances[boxes[i].id][user] = 0;
                payable(user).transfer(amount);
                emit EmergencyWithdraw(user, amount);
            }
        }
    }
    totalAmountWithdrawn += totalWithdrawn;
}


function emergencyWithdrawAll() external onlyOwner {
    for (uint256 i = 0; i < addressIndices.length; i++) {
        address user = addressIndices[i];
        uint256 amount = userBalance[user];
        if (amount > 0) {
            totalAmountWithdrawn += amount;
            userBalance[user] = 0;
            payable(user).transfer(amount);
            emit EmergencyWithdraw(user, amount);
        }
    }
}



in Mapper

Mapping public mappingContract;

// set the mapping contract address in the constructor or through a separate function
constructor(address _mappingContract) {
    mappingContract = Mapping(_mappingContract);
}

function emergencyWithdrawAllFromMapping() external onlyOwner {
    mappingContract.emergencyWithdrawAll();
}



