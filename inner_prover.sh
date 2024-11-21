#!/bin/bash

# Set your custom name
custom_name="myprover"

# Prompt user for mnemonic input
read -p "Enter your wallet mnemonic: " mnemonic

# Validate mnemonic input
if [ -z "$mnemonic" ]; then
    echo "Mnemonic cannot be empty. Please run the script again and provide a valid mnemonic."
    exit 1
fi

# Write mnemonic to .env file
if ! grep -q "MNEMONIC=" .env; then
    echo "MNEMONIC=$mnemonic" >> .env
else
    sed -i "s/MNEMONIC=.*/MNEMONIC=$mnemonic/" .env
fi

# Function to generate address from mnemonic using ethers.js
generate_address() {
    node -e "
    const { ethers } = require('ethers');
    const mnemonic = '$mnemonic';
    const wallet = ethers.Wallet.fromMnemonic(mnemonic);
    console.log(wallet.address);
    "
}

# Generate address and assign it to reward_address
reward_address=$(generate_address)

# Validate address generation
if [ -z "$reward_address" ]; then
    echo "Address generation failed. Please check if the mnemonic is valid."
    exit 1
fi

# Write reward address to .env file
if ! grep -q "REWARD_ADDRESS=" .env; then
    echo "REWARD_ADDRESS=$reward_address" >> .env
else
    sed -i "s/REWARD_ADDRESS=.*/REWARD_ADDRESS=$reward_address/" .env
fi

# Display the generated reward address
echo "Generated address: $reward_address"

# Kill any existing moz_prover process
pids=$(ps -ef | grep moz_prover | grep -v grep | awk '{print $2}')
if [ -n "$pids" ]; then
    echo "Terminating existing moz_prover processes: $pids"
    echo "$pids" | xargs kill
    sleep 5
fi

# Start moz_prover process in a loop
while true; do
    target=$(ps aux | grep moz_prover | grep -v grep)
    if [ -z "$target" ]; then
        echo "Starting moz_prover process..."
        ./moz_prover --mozaddress $reward_address --lumozpool moz.asia.zk.work:10010 --custom_name $custom_name
        sleep 5
    fi
    sleep 60
done
