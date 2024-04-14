import json
from robot.api.deco import keyword


@keyword('Compare Json Files')
def compare_json_files(actual_data, expected_data):
    if actual_data == expected_data:
        return True
    else:
        return False


@keyword('Verify Start With')
def verify_start_with(actual_data, expected_data):
    a_data = str(actual_data)
    e_data = str(expected_data)
    result = a_data.startswith(e_data)
    return result


@keyword('Verify End With')
def verify_end_with(actual_data, expected_data):
    a_data = str(actual_data)
    e_data = str(expected_data)
    result = a_data.endswith(e_data)
    assert result, True


@keyword('Verify Contain')
def verify_contain_with(actual_data, expected_data):
    a_data = str(actual_data)
    e_data = str(expected_data)
    result = e_data in a_data
    return result


@keyword('Update Dependant value')
def check_and_update_dependant_values(response_code, response, dependant_values, test):
    list_dependant_values = (dependant_values.split(" "))
    for i in range(0, len(list_dependant_values) - 1, 2):
        resp = list_dependant_values[i + 1]
        get_data = resp.split(",")
        if len(get_data) > 1:
            value_data = get_data[1].split(":")
            index = int(value_data[0])
            test[list_dependant_values[i]] = response.get(get_data[0])[index][value_data[1]]
        else:
            test[list_dependant_values[i]] = response.get(get_data[0])
