import pandas as pd

"""
============================================================
    Example Data file
    ~~~~~~~~~~~~~~~~~
    +-------------+--------------------------------------------------------------------------------+--------------+
    {policy_type}  | {rule_name}                                                                   |{test}
    ACHRDFI        |Alert by Risk Level                                                            |abc
    Check          |High Focus Bank Rule,Unusual Routing Number Digits Rule                        |xyz
    Wire           |Wire Multiple Payments Per Day Rule,Wire New Payee High Amount Rule            |ship, boat
    ACHODFI        |New Payee and Amount threshold Rule,New Payee and Amount threshold Rule        |orange, apple
    +-------------+--------------------------------------------------------------------------------+--------------+
============================================================
    Usage example in .robot files
    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

        *** Settings ***
        Library  ../../Library/CsvUtil.py
        
        *** Keywords ***
        Read CSV Data
            [Arguments]     ${testDataFile}
            ${testData}=    CsvUtil.Get Data   ${testDataFile}
            Log Many    ${testData}
        
        Read CSV Headers
            [Arguments]     ${testDataFile}
            ${testDataHeader}=    CsvUtil.Get Header    ${testDataFile}
            Log Many    ${testDataHeader}
        
        Read CSV Total Rows
            [Arguments]     ${testDataFile}
            ${totalRows}=    CsvUtil.Get Total Rows    ${testDataFile}
            Log Many    ${totalRows}
        
        Update CSV column
            [Arguments]     ${testDataFile}     ${columnName}   ${oldValue}     ${newValue}
            CsvUtil.Update Column    ${testDataFile}    ${columnName}   ${oldValue}     ${newValue}
        
        Delete CSV Column
            [Arguments]     ${testData}     ${columnName}   ${value}
            CsvUtil.Delete Column    ${testData}    ${columnName}    ${value}
============================================================
"""


# Reading the CSV file with UTF-8 encoding and '|' delimiter
def get_data(csv_file_path, user_defined_delimiter='|'):
    try:
        df = pd.read_csv(csv_file_path, encoding='utf-8', header=0, delimiter=user_defined_delimiter)
        return df.to_dict(orient='records')
    except FileNotFoundError:
        raise Exception(f"File '{csv_file_path}' not found.")


# Reading the CSV file Column wise
def get_data_by_column(csv_file_path, column_name=None, user_defined_delimiter='|'):
    try:
        df = pd.read_csv(csv_file_path, encoding='utf-8', header=0, delimiter=user_defined_delimiter)

        if column_name:
            # If column_name is provided, return only that column
            if column_name in df.columns:
                return df[column_name].tolist()
            else:
                print(f"Column '{column_name}' not found in the DataFrame.")
                return None
        else:
            # If no column_name is provided, return all columns
            data_dict = {column: df[column].tolist() for column in df.columns}
            return data_dict
    except FileNotFoundError:
        print(f"File '{csv_file_path}' not found.")
        return None


def get_header(csv_file_path, user_defined_delimiter='|'):
    try:
        return pd.read_csv(csv_file_path, encoding='utf-8', header=0, delimiter=user_defined_delimiter, nrows=1).columns.tolist()
    except FileNotFoundError:
        raise Exception(f"File '{csv_file_path}' not found.")


def get_total_rows(csv_file_path, user_defined_delimiter='|'):
    try:
        df = pd.read_csv(csv_file_path, encoding='utf-8', header=0, delimiter=user_defined_delimiter)
        return len(df.index)
    except FileNotFoundError:
        raise Exception(f"File '{csv_file_path}' not found.")


# update_value_column the CSV file without row /record to update
def update_column(csv_file_path, column_name, old_value, new_value, user_defined_delimiter='|'):
    try:
        df = pd.read_csv(csv_file_path, encoding='utf-8', header=0, delimiter=user_defined_delimiter)
        if column_name not in df.columns.tolist():
            raise ValueError(f"Column '{column_name}' not found in the datafile!")
        if old_value not in df[column_name].values:
            raise ValueError(f"Value '{old_value}' not found in the column '{column_name}'.")
        df.loc[df[column_name] == old_value, column_name] = new_value
        df.to_csv(csv_file_path, index=False, sep=user_defined_delimiter)
        print("CSV file updated successfully.")
    except Exception as e:
        raise Exception(f"An error occurred: {str(e)}")
    except FileNotFoundError:
        raise Exception(f"File '{csv_file_path}' not found.")


# Delete the column if the specified value is found
def delete_column(csv_file_path, column_name, value, user_defined_delimiter='|'):
    try:
        df = pd.read_csv(csv_file_path, encoding='utf-8', header=0, delimiter=user_defined_delimiter)

        if column_name not in df.columns:
            raise ValueError(f"Column '{column_name}' not found in the datafile. Delete Column failed!")
        if (df[column_name] == value).any():
            df.drop(column_name, axis=1, inplace=True)
            print(f"Column '{column_name}' deleted successfully.")
        else:
            raise ValueError(f"Column with value '{value}' not found in the datafile. Delete Column failed!")

        df.to_csv(csv_file_path, index=False, sep=user_defined_delimiter)
    except Exception as e:
        raise Exception(f"An error occurred: {str(e)}")
    except FileNotFoundError:
        raise Exception(f"File '{csv_file_path}' not found.")


# Delete the complete column directly by column name
def delete_complete_column(csv_file_path, column_name, user_defined_delimiter='|'):
    try:
        df = pd.read_csv(csv_file_path, encoding='utf-8', header=0, delimiter=user_defined_delimiter)
        if column_name in df.columns:
            df.drop(column_name, axis=1, inplace=True)
            print(f"Column '{column_name}' deleted successfully.")
        else:
            raise ValueError(f"Column '{column_name}' not found in the datafile. Delete Column failed!")

        df.to_csv(csv_file_path, index=False, sep=user_defined_delimiter)
    except Exception as e:
        raise Exception(f"An error occurred: {str(e)}")
    except FileNotFoundError:
        raise Exception(f"File '{csv_file_path}' not found.")
