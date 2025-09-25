#!/bin/bash
# save as xargs_requests.sh
# simple HTTP benchmark script

URL="http://192.168.1.51:23456/albums"
REQUESTS=100000
MAX_PROCS=$(nproc)
TMPFILE=$(mktemp)
echo $TMPFILE

echo "Launching $REQUESTS requests with $MAX_PROCS parallel processes..."
START_TIME=$(date +%s.%N)

# Fire off requests, capture only status codes into tmpfile
seq 1 $REQUESTS | xargs -n 1 -P $MAX_PROCS -I {} \
  curl -s -o /dev/null -w "%{http_code}\n" --max-time 1 "$URL" >> "$TMPFILE"

END_TIME=$(date +%s.%N)
DURATION=$(echo "$END_TIME - $START_TIME" | bc)

# Count results
SUCCESS=$(grep -c '^200$' "$TMPFILE")
FAILED=$(( REQUESTS - SUCCESS ))
RPS=$(echo "scale=2; $SUCCESS / $DURATION" | bc)

echo "--------------------------------------------------------"
echo "Requests attempted: $REQUESTS"
echo "Successful (HTTP 200): $SUCCESS"
echo "Failed (non-200 or error): $FAILED"
echo "Total Time: ${DURATION} seconds"
echo "Throughput (approx): ${RPS} req/sec"
echo ""
echo "Note: Curl exits nonzero on certain errors (e.g. connection refused), so"
echo "we log fewer lines than $REQUESTS in those cases. Thus, FAILED = REQUESTS - lines_in_tmpfile."
echo ""
echo "Tip: For deeper benchmarking/latency histograms, consider wrk, hey, ab, or vegeta."