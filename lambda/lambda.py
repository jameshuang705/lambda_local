# to use a dependency within theh lambda function, install it in the packages directory
import opensearchpy

def handler(event, _ctx):
    print("Your content here!")
    return {
        "result": "hi"
    }
