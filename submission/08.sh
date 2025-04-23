# what block height was this tx mined ?
tx_id=49990a9c8e60c8cba979ece134124695ffb270a98ba39c9824e42c4dc227c7eb

blockhash=$(bitcoin-cli -signet getrawtransaction $tx_id true | jq -r '.blockhash')

bitcoin-cli -signet getblock $blockhash | jq -r '.height'