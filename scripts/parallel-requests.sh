#!/bin/bash
# save as parallel_requests.sh

URL="192.168.1.59:2343/albums"
REQUESTS=10000
CORES=$(nproc)

echo "Making $REQUESTS requests using $CORES parallel processes..."
START_TIME=$(date +%s.%N)

seq 1 $REQUESTS | parallel -j $CORES curl -s "$URL" > /dev/null

echo "Completed $REQUESTS requests"

END_TIME=$(date +%s.%N)
DURATION=$(echo "$END_TIME - $START_TIME" | bc)
RPS=$(echo "scale=2; $REQUEST_COUNT / $DURATION" | bc)

echo "--------------------------------------------------------"
echo "All requests initiated."
echo "Total Time: ${DURATION} seconds"
echo "Requests Per Second (approx): ${RPS}"
echo "Note: This measures initiation speed, not necessarily completion or server-side latency."
echo "      For more accurate metrics, use dedicated load testing tools."