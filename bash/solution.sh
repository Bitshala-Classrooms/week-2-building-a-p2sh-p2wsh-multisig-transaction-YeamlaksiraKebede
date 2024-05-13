# Write your solution here
#!/bin/bash

# Private keys
privkey1="39dc0a9f0b185a2ee56349691f34716e6e0cda06a7f9707742ac113c4e2317bf"
privkey2="5077ccd9c558b7d04a81920d38aa11b4a9f9de3b23fab45c3ef28039920fdd6d"

# Redeem script
redeem_script_hex="5221032ff8c5df0bc00fe1ac2319c3b8070d6d1e04cfbf4fedda499ae7b775185ad53b21039bbc8d24f89e5bc44c5b0d1980d6658316a6b2440023117c3c03a4975b04dd5652ae"

# Destination address
dest_address="325UUecEQuyrTd28Xs2hvAxdAjHM7XzqVF"

# Create unsigned transaction
unsigned_tx=$(bitcoin-cli createrawtransaction '[{"txid":"0000000000000000000000000000000000000000000000000000000000000000","vout":0}]' '{"'$dest_address'":0.001}')

# Sign transaction with private key 1
signed_tx1=$(bitcoin-cli signrawtransactionwithkey $unsigned_tx '["'$privkey1'"]' "[{\"txid\":\"0000000000000000000000000000000000000000000000000000000000000000\",\"vout\":0,\"scriptPubKey\":\"$redeem_script_hex\"}]" "ALL")

# Sign transaction with private key 2
signed_tx=$(echo $signed_tx1 | jq -r '.hex' | bitcoin-cli signrawtransactionwithkey stdin '["'$privkey2'"]' "[{\"txid\":\"0000000000000000000000000000000000000000000000000000000000000000\",\"vout\":0,\"scriptPubKey\":\"$redeem_script_hex\"}]" "ALL" | jq -r '.hex')

# Output transaction hex to out.txt
echo $signed_tx > out.txt

