#!/bin/bash

# Set the SPARQL endpoint URL
SPARQL_ENDPOINT="http://localhost/blazegraph/namespace/kb/sparql"

# Set the PREFIX
PREFIX="PREFIX itonics:<http://itonics.org/>"

# Set the SPARQL update queries
SPARQL_QUERIES=(
  "INSERT DATA { itonics:SoftwareCompany rdf:type itonics:Company }"
  "INSERT DATA { itonics:ChairmanEVPStrategy rdf:type itonics:Person .
                 itonics:SoftwareCompany itonics:hasExecutive itonics:ChairmanEVPStrategy }"
  "INSERT DATA { itonics:CEO rdf:type itonics:Person .
                 itonics:SoftwareCompany itonics:hasExecutive itonics:CEO .
                 itonics:CEO itonics:hasExecutive itonics:COO .
                 itonics:CEO itonics:hasExecutive itonics:SolutionEngineer }"
)

# Function to URL encode a string
url_encode() {
  local string="$1"
  local strlen=${#string}
  local encoded=""
  local index

  for ((index = 0; index < strlen; ++index)); do
    local char="${string:index:1}"
    case $char in
      [a-zA-Z0-9.~_-])
        encoded+="$char"
        ;;
      *)
        printf -v char '%%%02X' "'$char"
        encoded+="$char"
        ;;
    esac
  done

  echo "$encoded"
}

# Execute the curl commands and check the status code
for SPARQL_QUERY in "${SPARQL_QUERIES[@]}"; do
  # Combine PREFIX and SPARQL_QUERY
  FULL_QUERY="$PREFIX $SPARQL_QUERY"

  # URL encode the combined query
  ENCODED_QUERY=$(url_encode "$FULL_QUERY")

  # Run the curl command
  curl -X POST ${SPARQL_ENDPOINT} \
    -H "Accept: */*" \
    -H "Accept-Language: en-GB,en-US;q=0.9,en;q=0.8" \
    -H "Connection: keep-alive" \
    -H "Content-Type: application/x-www-form-urlencoded; charset=UTF-8" \
    -H "Origin: http://localhost" \
    -H "Referer: http://localhost/blazegraph/" \
    -H "Sec-Fetch-Dest: empty" \
    -H "Sec-Fetch-Mode: cors" \
    -H "Sec-Fetch-Site: same-origin" \
    -H "User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36" \
    -H "X-Requested-With: XMLHttpRequest" \
    -H 'sec-ch-ua: "Not_A Brand";v="8", "Chromium";v="120", "Google Chrome";v="120"' \
    -H 'sec-ch-ua-mobile: ?0' \
    -H 'sec-ch-ua-platform: "macOS"' \
    --data-raw "update=$ENCODED_QUERY" \
    --compressed
done
