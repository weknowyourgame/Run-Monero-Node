#!/bin/bash

set -e

echo "Starting Tor..."
tor &

sleep 10

echo "Starting Monero daemon..."
/home/monero/monerod --config-file /home/monero/.bitmonero/monerod.conf --non-interactive
