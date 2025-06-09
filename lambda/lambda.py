# to use a dependency within theh lambda function, install it in the packages directory
import ssl
import json
from pprint import pprint
from opensearchpy import OpenSearch

# note these credentials/host corresponds to docker environment
host = "https://os-lambda-node:9200"
username = "admin"
password = "LUidvhKrbmjcEXfFny49"

def handler(event, _ctx):
    print("Your content here!")

    client = OpenSearch(
        hosts=[host],
        http_auth=(username, password),
        verify_certs=False,
        ssl_context=ssl._create_unverified_context()
    )

    response = client.cluster.health()
    pprint(response)
    return response
