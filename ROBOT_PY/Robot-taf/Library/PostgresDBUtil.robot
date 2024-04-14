[Metadata]    Author    Owais Jilani
*** Settings ***

Library    DatabaseLibrary 
Resource   ../Settings/config.robot

*** Keywords ***  

#************** POSTGRES KEYWORDS FOR CONNECTION,FETCHING, UPDATING, DELETING DATA ************** 

Connect to PostgreSQL
    Connect To Database    psycopg2    database=${${ENV}_POSTGRESDB_CONFIG.DB}    user=${${ENV}_POSTGRESDB_CONFIG.USER}   password=${${ENV}_POSTGRESDB_CONFIG.PASSWORD}    host=${${ENV}_POSTGRESDB_CONFIG.HOST}   port=${${ENV}_POSTGRESDB_CONFIG.PORT}

Connect to MySQL
    Connect To Database    MySQLdb     database=${${ENV}_POSTGRESDB_CONFIG.DB}    user=${${ENV}_POSTGRESDB_CONFIG.USER}   password=${${ENV}_POSTGRESDB_CONFIG.PASSWORD}    host=${${ENV}_POSTGRESDB_CONFIG.HOST}   port=${${ENV}_POSTGRESDB_CONFIG.PORT}

Get Data From PostgreSQL
    [Arguments]    ${query}
    @{result}    Query    ${query}
    [Return]    ${result}

Validate PostgreSQL Data
    [Arguments]    ${query}    ${expected_result}
    ${actual_result}    Get Data From PostgreSQL    ${query}
    Should Be Equal As Strings    ${actual_result}    ${expected_result}

Update Data In PostgreSQL
    [Arguments]    ${query}    ${update_statement}
    Execute Sql String    ${update_statement}

Drop PostgreSQL Table
    [Arguments]    ${table_name}
    Execute Sql String    DROP TABLE ${table_name};

Delete Data From PostgreSQL
    [Arguments]    ${table_name}    ${condition}
    Execute Sql String    DELETE FROM ${table_name} WHERE ${condition};

Close PostgreSQL Connection
    Disconnect From Database
