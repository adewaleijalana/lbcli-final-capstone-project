# How many satoshis did this transaction pay for fee?: b71fb9ab7707407cc7265591e0c0d47d07afede654f91de1f63c0cb522914bcb

tx_id="b71fb9ab7707407cc7265591e0c0d47d07afede654f91de1f63c0cb522914bcb"

#6d5d134b8d3c02d88196d8f483fbff5a9bb121bf8c53e5967f287cdf17f6d0bc

previous_txid=$(bitcoin-cli -signet getrawtransaction $tx_id true | jq -r '.vin | .[0] | .txid')

previous_vout_value=$(bitcoin-cli -signet getrawtransaction $previous_txid true | jq -r '.vout | .[0] | .value' | awk '{s += $1 * 100000000} END {print s}')

current_vout_value=$(bitcoin-cli -signet getrawtransaction $tx_id true | jq -r '.vout | .[] | .value' | awk '{s += $1 * 100000000} END {print s}')

FEE_SATS=$(($previous_vout_value - $current_vout_value))

echo $FEE_SATS

