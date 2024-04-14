*** Settings ***

Library    MongoDBLibrary
Library    Collections
Resource    ../../Library/MongoDBUtil.robot
Resource    ../../Library/TestSetup.robot

*** Test Cases ***

TC-001 Get Data Customers From MongoDB
    Connect To MongoDB    localhost    27017
    ${query}    Set Variable    {"name": "John Doe"}
    Get Data From MongoDB    customers    ${query} 

TC-002 Retrieve and Update Customer Email
    Open Connection To MongoDB
    # Define the query to find the document you want to update
    ${query}    Set Variable    {"name": "John Doe"}
    # Define the update to be applied
    ${update}    Set Variable    {"$set": {"email": "johnjilani@example.com"}}
    # Retrieve and update one document
    Retrieve and Update Mongodb Record    db1    customers    ${query}    ${update}
   
TC-003 Retrieve and Update Customer Name
    Open Connection To MongoDB
    # Define the query to find the document you want to update
    ${query}    Set Variable    {"name": "John Doe"}
    # Define the update to be applied (update the "name" field)
    ${update}    Set Variable    {"$set": {"name": "Owais Shaikh"}}
    # Retrieve and update one document
    &{result}    Retrieve and Update One Mongodb Record    db1    customers    ${query}    ${update}
    # Log the updated document (result)
    Log    Updated Document: ${result}
    
TC-004 Connect to MongoDB and Retrieve All Collection Data
    Open Connection To MongoDB
    Connect To MongoDB    localhost    27017
    ${allResults}	Retrieve All MongoDB Records	db1    customers
    Log	            ${allResults}
    Close MongoDB Connection