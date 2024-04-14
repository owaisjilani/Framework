import json
import pandas as pd
from robot.api.deco import keyword


@keyword('Add Json Data To CSV File')
def add_json_data_to_csv(csv_file, api_file):
    flattened_data = []
    with open(api_file) as f:
        json_data = json.load(f)
    for entry in json_data:
        flat_entry = entry.copy()
        flat_entry.update(entry["TEST_DATA"])
        del flat_entry["TEST_DATA"]
        flattened_data.append(flat_entry)
        df = pd.DataFrame(flattened_data)
    df.columns = ["${TEST}", "${BASEURL_ACTION}", "${DEPENDENT_FLAG}", "${IS_DEPENDENT_FLAG_REQUIRED}",
                  "${RELATIVE_URI}", "${REQUEST_TYPE}", "${EXCEPTED_RESPONSE_STATUS}", "${RESPONSE_BODY}",
                  "${RESPONSE_BODY_EXACT_MATCH}", "${RESPONSE_BODY_CASE_SENSITIVE}", "${RESPONSE_BODY_START_WITH}",
                  "${RESPONSE_BODY_END_WITH}", "${RESPONSE_BODY_CONTAINS}", "${REQUEST_BODY}",
                  "${DEPENDENT_VALUES}", "${ATTACHMENT}"]
    df.head()
    df.to_csv(csv_file, index=False, sep=";")
