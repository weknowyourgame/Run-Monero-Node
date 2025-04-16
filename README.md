# Run a Monero Node

> I believe in privacy—especially financial privacy. Everyone has the right to control their own data, make transactions freely, and stay anonymous if they choose. Tools like Monero and Tor help make that a reality.

> Monero nodes validate and relay private transactions, keeping the blockchain updated. They ensure anonymity using ring signatures and stealth addresses. Some run over Tor using .onion addresses to enhance privacy and network anonymity.

## Enjoy radical financial freedom

### Why should i run a Monero Node
- If you do not run your own node, you are relying on other's nodes to verify and send your transactions
- Contribute to the decentralization of the Monero network
- To independently have the ability to send/receive/verify transactions while maintaining the highest privacy and security

### You can run 2 types of nodes
- Full Node: Stores all blockchain data
- Pruned Node: Stores a random 1/8th of the blockchain's data

### Minimum Requirements
- Dual-core CPU
- 4+ GB RAM
- 160GB+ SSD HD (Full Node)
- 80GB+ SSD HD (Pruned Node)

## How to Run This Node

### Quick Start
1. Make sure Docker is installed on your system
2. Clone this repository
3. Build and start the container:
   ```
   docker compose up -d
   ```

### Check Node Status
To check if your node is running properly:

```
# View logs
docker logs -f monero-node

# Check running processes
docker exec monero-node ps aux

# Check node status and sync progress
docker exec monero-node /home/monero/monerod status
```

### Verify Tor Connection
To verify that your node is correctly using Tor:

```
# Install curl in the container if needed
docker exec -u root monero-node apt-get update
docker exec -u root monero-node apt-get install -y curl

# Test Tor connectivity
docker exec monero-node curl --socks5 127.0.0.1:9050 https://check.torproject.org/api/ip
```

A successful response will show: `{"IsTor":true,"IP":"xxx.xxx.xxx.xxx"}`

### Access RPC Interface
The node exposes an RPC interface on port 18089:

```
curl http://localhost:18089/json_rpc -d '{"jsonrpc":"2.0","id":"0","method":"get_info"}' -H 'Content-Type: application/json'
```

### Container Configuration

- The node runs in pruned mode to save disk space
- Transactions are routed through Tor for privacy
- Data is persisted in a Docker volume named `monero_data`
