# what is the coinbase tx in this block 243,834

coinbase_txid=$(bitcoin-cli -signet getblock $(bitcoin-cli -signet getblockhash 243834) | jq -r '.tx[0]')

echo $coinbase_txid
