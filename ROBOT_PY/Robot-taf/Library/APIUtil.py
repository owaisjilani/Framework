import json
import jsonschema
import os

def validate_schema(input_json, reference_schema_path):
    reference_schema = None
    cwd = os.getcwd()
    script_directory = os.path.dirname(os.path.abspath(__file__))
    # Go up one level to the project root
    project_root = os.path.dirname(script_directory)
    # Construct the download path by joining the project root with 'Resources\TestDataAPI\Schemas'
    download_path = os.path.join(project_root, 'Resources','TestDataAPI','Schemas',reference_schema_path)
    with open(reference_schema_path) as json_file:
        reference_schema = json.load(json_file)
    jsonschema.validate(instance=input_json, schema=reference_schema)