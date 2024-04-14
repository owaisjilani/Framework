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
        Library  ../../Library/ExcelUtil.py
        
        *** Keywords ***
        Read Excel Data
            [Arguments]     ${testDataFile}
            ${testData}=    ExcelUtil.Get Data   ${testDataFile}
            Log Many    ${testData}
        
        Read Excel Headers
            [Arguments]     ${testDataFile}
            ${testDataHeader}=    ExcelUtil.Get Header    ${testDataFile}
            Log Many    ${testDataHeader}
        
        Read Excel Total Rows
            [Arguments]     ${testDataFile}
            ${totalRows}=    ExcelUtil.Get Total Rows    ${testDataFile}
            Log Many    ${totalRows}
        
        Update Excel column
            [Arguments]     ${testDataFile}     ${columnName}   ${oldValue}     ${newValue}
            ExcelUtil.Update Column    ${testDataFile}    ${columnName}   ${oldValue}     ${newValue}
        
        Delete Excel Column
            [Arguments]     ${testData}     ${columnName}   ${value}
            ExcelUtil.Delete Column    ${testData}    ${columnName}    ${value}
============================================================
"""


# Reading the Excel file Row wise
def get_data(excel_file_path):
    try:
        df = pd.read_excel(excel_file_path)
        return df.to_dict(orient='records')
    except FileNotFoundError:
        print(f"File '{excel_file_path}' not found.")


# Reading the Excel file Column wise
def get_data_by_column_name(excel_file_path, column_name=None):
    try:
        df = pd.read_excel(excel_file_path)

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
        print(f"File '{excel_file_path}' not found.")
        return None


def get_header(excel_file_path):
    try:
        return pd.read_excel(excel_file_path, nrows=1).columns.tolist()
    except FileNotFoundError:
        raise Exception(f"File '{excel_file_path}' not found.")


def get_total_rows(excel_file_path):
    try:
        df = pd.read_excel(excel_file_path)
        return len(df.index)
    except FileNotFoundError:
        raise Exception(f"File '{excel_file_path}' not found.")


# update_value_column the Excel file without row /record to update
def update_column(excel_file_path, column_name, old_value, new_value):
    try:
        df = pd.read_excel(excel_file_path)
        if column_name not in df.columns.tolist():
            raise ValueError(f"Column '{column_name}' not found in the datafile!")
        if old_value not in df[column_name].values:
            raise ValueError(f"Value '{old_value}' not found in the column '{column_name}'.")
        df.loc[df[column_name] == old_value, column_name] = new_value
        df.to_excel(excel_file_path, index=False)
        print("Excel file updated successfully.")
    except Exception as e:
        raise Exception(f"An error occurred: {str(e)}")
    except FileNotFoundError:
        raise Exception(f"File '{excel_file_path}' not found.")


# Delete the column if the specified value is found
def delete_column(excel_file_path, column_name, value):
    try:
        df = pd.read_excel(excel_file_path)

        if column_name not in df.columns:
            raise ValueError(f"Column '{column_name}' not found in the datafile. Delete Column failed!")
        if (df[column_name] == value).any():
            df.drop(column_name, axis=1, inplace=True)
            print(f"Column '{column_name}' deleted successfully.")
        else:
            raise ValueError(f"Column with value '{value}' not found in the datafile. Delete Column failed!")

        df.to_excel(excel_file_path, index=False)
    except Exception as e:
        raise Exception(f"An error occurred: {str(e)}")
    except FileNotFoundError:
        raise Exception(f"File '{excel_file_path}' not found.")


# Delete the complete column directly by column name
def delete_complete_column(excel_file_path, column_name):
    try:
        df = pd.read_excel(excel_file_path)
        if column_name in df.columns:
            df.drop(column_name, axis=1, inplace=True)
            print(f"Column '{column_name}' deleted successfully.")
        else:
            raise ValueError(f"Column '{column_name}' not found in the datafile. Delete Column failed!")

        df.to_excel(excel_file_path, index=False, sep='|')
    except Exception as e:
        raise Exception(f"An error occurred: {str(e)}")
    except FileNotFoundError:
        raise Exception(f"File '{excel_file_path}' not found.")