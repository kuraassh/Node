#!/bin/bash
if [ -z $DISCORD ]; then
        read -p "Enter your discord: " DISCORD
        echo 'export DISCORD='$DISCORD >> $HOME/.profile
fi
echo 'your discord: ' $DISCORD
sleep 1

echo "-----------------------------------------------------------------------------"
echo "Generate new wallet"
echo "-----------------------------------------------------------------------------"
# Generate new wallet
cd $HOME/massa/massa-client
./massa-client --pwd $massa_pass wallet_generate_secret_key

echo "-----------------------------------------------------------------------------"
echo "Echo wallet address"
echo "-----------------------------------------------------------------------------"
#Echo wallet address
ADDRESS=$(./massa-client --pwd $massa_pass wallet_info | grep Address | awk '{ print $2 }')
echo $ADDRESS

echo "-----------------------------------------------------------------------------"
echo "Echo wallet secret"
echo "-----------------------------------------------------------------------------"
#Echo wallet secret
SECRET=$(./massa-client --pwd $massa_pass wallet_get_secret_key $ADDRESS | grep "S12")
echo $SECRET

echo "-----------------------------------------------------------------------------"
echo "Add staking"
echo "-----------------------------------------------------------------------------"
#Add staking
./massa-client --pwd $massa_pass node_start_staking $ADDRESS

echo "-----------------------------------------------------------------------------"
echo "Registration to episode "
echo "-----------------------------------------------------------------------------"
#Registration to episode 
REG=$(./massa-client --pwd $massa_pass node_testnet_rewards_program_ownership_proof $ADDRESS $DISCORD)
echo $REG

echo "-----------------------------------------------------------------------------"
echo "Echo all data to file"
echo "-----------------------------------------------------------------------------"
#Echo all data to file 
echo $ADDRESS $SECRET $REG > massa_20.txt

echo "Your data"
echo -e "${PINK}-----------------------------------------------------------------------------${NORMAL}"
#Your data
cat massa_20.txt
