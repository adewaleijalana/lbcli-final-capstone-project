# Only one tx in block 243,821 signals opt-in RBF. What is its txid?

blockhash_243821=$(bitcoin-cli -signet getblockhash 243821)

txids=$(bitcoin-cli -signet getblock $blockhash_243821 | jq -r '.tx[]')

for txid in $txids; do
  if bitcoin-cli -signet getrawtransaction "$txid" true | jq -e '.vin[0] | has("coinbase")' > /dev/null; then
    continue
  fi

  SIGNALS_RBF=$(bitcoin-cli -signet getrawtransaction "$txid" true | jq '[.vin[].sequence] | map(select(. < 4294967294)) | length > 0')

  if [[ "$SIGNALS_RBF" == "true" ]]; then
    echo "$txid"
    exit 0
  fi
done