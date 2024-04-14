[Metadata]    Author    Owais Jilani
*** Settings ***  

Library    MongoDBLibrary  
Resource   ../Settings/config.robot

*** Keywords ***  

#************** MONGODB KEYWORDS FOR CONNECTION,FETCHING, UPDATING, DELETING DATA ************** 
Open Connection To MongoDB
   Connect To MongoDB    ${${ENV}_MONGODB_CONFIG.IP}    ${${ENV}_MONGODB_CONFIG.PORT} 

Connect to MongoDB With URI
    ${URI}    Evaluate    f'mongodb+srv://${${ENV}_MONGODB_CONFIG.USERNAME}:${${ENV}_MONGODB_CONFIG.PASSWORD}@${${ENV}_MONGODB_CONFIG.IP}/${${ENV}_MONGODB_CONFIG.DB}'
    Connect To MongoDB    ${URI}

Drop Database MongoDB 
    [Arguments]    ${DB_Name}=db1
    Drop MongoDB Database    ${DB_Name}
    ${allCollections}	Get MongoDB Collections	    ${DB_Name}
    Should Be Empty	    ${allCollections}
    ${allDBs}	        Get Mongodb Databases
    Should Not Contain  ${allDBs}                   ${DB_Name}

Get Data From MongoDB
    [Arguments]    ${collection_name}               ${query}   
    ${data}        Retrieve Some MongoDB Records    ${${ENV}_MONGODB_CONFIG.DB}    ${collection_name}    ${query}  
    [Return]       ${data}

Remove Data From MongoDB
    [Arguments]        ${db_name}                ${collection_name}    ${query}
    ${result}          Remove Mongodb Records    ${db_name}            ${collection_name}    ${query}
    Log    Remove Result: ${result}

Retrieve And Update MongoDB Record
    [Arguments]    ${db_name}    ${collection_name}    ${query}    ${update_data}    ${return_before_document}=False
    ${result}    Retrieve And Update One Mongodb Record    ${db_name}    ${collection_name}    ${query}    ${update_data}    ${return_before_document}
    Log    Retrieve and Update Result: ${result}

Retrieve And Validate MongoDB Records
    [Arguments]    ${db_name}    ${collection_name}    ${query}    ${expected_results}
    ${actual_results}    Retrieve Some Mongodb Records    ${db_name}    ${collection_name}    ${query}
    Log Many    ${actual_results}
    Should Contain    ${actual_results}    ${expected_results}

Close MongoDB Connection
    Disconnect From Mongodb

    