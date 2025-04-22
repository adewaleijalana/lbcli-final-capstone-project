# How many new outputs were created by block 243,825?

bitcoin-cli -signet -rpcconnect=127.0.0.1 getblockstats 243825 | jq -r '.outs'
