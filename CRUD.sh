#Create
curl -X POST -H "Content-Type: application/x-www-form-urlencoded" \
  --data-urlencode "update=INSERT DATA { <http://example.org/resource/1> <http://example.org/property/name> 'John Doe' }" \
  http://your-blazegraph-endpoint/bigdata/sparql

#Read
curl -X GET -G --data-urlencode "query=SELECT ?subject ?name WHERE { ?subject <http://example.org/property/name> ?name }" \
  http://your-blazegraph-endpoint/bigdata/sparql

#Update
curl -X POST -H "Content-Type: application/x-www-form-urlencoded" \
  --data-urlencode "update=DELETE DATA { <http://example.org/resource/1> <http://example.org/property/name> 'John Doe' }" \
  --data-urlencode "update=INSERT DATA { <http://example.org/resource/1> <http://example.org/property/name> 'Updated Name' }" \
  http://your-blazegraph-endpoint/bigdata/sparql

#Delete
curl -X POST -H "Content-Type: application/x-www-form-urlencoded" \
  --data-urlencode "update=DELETE DATA { <http://example.org/resource/1> <http://example.org/property/name> 'Updated Name' }" \
  http://your-blazegraph-endpoint/bigdata/sparql


