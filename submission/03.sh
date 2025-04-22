# Which tx in block 216,351 spends the coinbase output of block 216,128?

coinbase_txid=$(bitcoin-cli -signet getblock $(bitcoin-cli -signet getblockhash 216128) | jq -r '.tx[0]')

blockhash_216351=$(bitcoin-cli -signet getblockhash 216351)

txids=$(bitcoin-cli -signet getblock $blockhash_216351 | jq -r '.tx[]')

for txid in $txids; do
  bitcoin-cli -signet getrawtransaction $txid true | jq -r --arg cb "$coinbase_txid" 'select(.vin[]?.txid == $cb) | .txid'
done
