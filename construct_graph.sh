# Set the endpoint URL
ENDPOINT_URL="http://localhost/blazegraph/sparql"

# Define PREFIX
PREFIX="PREFIX itonics: <http://itonics.org/>"

# Send the SPARQL update from the file
curl -X POST -H "Content-Type: application/sparql-update" \
  --data-binary "@update.sparql" \
  -w "%{http_code}" \
  "$ENDPOINT_URL"
