[Metadata]    Author    Owais Jilani
*** Variables ***

${ENV}                                  AUTO
${ZOOM_PERCENTAGE}                      100
${APP_URL}                              https://www.saucedemo.com/
${AUTO_APP_URL}                         https://www.saucedemo.com/
${ACCESS_MANAGEMENT_URL}                ${${ENV}_APP_URL}inventory.html
${CartUrl}                              ${${ENV}_APP_URL}cart.html
${AUTO_APP_LOGIN_URL}                   https://www.saucedemo.com/
${BETA_APP_LOGIN_URL}                   https://www.saucedemo.com/
&{DELAY}                                VERYSHORT=800ms    SHORT=4s    MEDIUM=10s    LONG=20s    VERYLONG=60s    SHORTEST=300ms
${COOKIE}
${Logged Username}
${USER}
${DEFAULT_COMMENT}                      Automation Script Attachment

#*********Upload/Download Related File and Location *************************

${DEFAULT_UPLOAD}                       testFile1.jpeg  #Location Resources/TestFiles/

#************** MONGODB CONNECTION VARIABLES ***********
&{DEV_MONGODB_CONFIG}           IP=atlascluster.tt2p8fh.mongodb.net   PORT=27017      DB=os    USERNAME=owaisjilani     PASSWORD=owais  
&{SALES_MONGODB_CONFIG}          IP=${EMPTY}    PORT=${EMPTY}    DB=db1
&{QA_MONGODB_CONFIG}             IP=${EMPTY}    PORT=${EMPTY}    DB=db1

#************** POSTGRES CONNECTION VARIABLES ***********
&{DEV_POSTGRESDB_CONFIG}        USER=admin    PASSWORD=${EMPTY}    HOST=172.17.0.1    PORT=5432    DB=db1
&{SALES_POSTGRESDB_CONFIG}      USER=admin    PASSWORD=${EMPTY}    HOST=172.17.0.1    PORT=5432    DB=db1
&{QA_POSTGRESDB_CONFIG}         USER=admin    PASSWORD=${EMPTY}    HOST=172.17.0.1    PORT=5432    DB=db1

#************** MYSQL CONNECTION VARIABLES ***********

&{DEV_MYSQL_CONFIG}        USER=admin    PASSWORD=${EMPTY}    HOST=172.17.0.1    PORT=5432    DB=db1
&{SALES_MYSQL_CONFIG}      USER=admin    PASSWORD=${EMPTY}    HOST=172.17.0.1    PORT=5432    DB=db1
&{QA_MYSQL_CONFIG}         USER=admin    PASSWORD=${EMPTY}    HOST=172.17.0.1    PORT=5432    DB=db1

#************* API FILE NAME ****************
${CASEAPI}              fw-json${/}data${/}caseapi
${ALERTAPI}             fw-json${/}data${/}alertapi
${CASEFILE}              fw-json${/}data${/}case_data.csv
${ALERTFILE}              fw-json${/}data${/}alert_data.csv

#****************AWS S3 Bucket Secrets ****************
${AWS_ACCESS_KEY_ID}         OWAKIA2VVNEBTXSHMMSYELAIS
${AWS_SECRET_ACCESS_KEY}     67VAHGwOY4GGxew3qEj2ZOrwHaaCViL+sTUpnnoC6g86
${BUCKET_NAME}               auto
${REPORT_BUCKET}             automation
${KeyInbound}                inbound/
${keyValid}                  inbound/valid/
${KeyWarning}                data-validation/warning/
${REGION_NAME}               us-west-2
${DownloadBucket}            auto-data
#${DownloadKey}               DataIntakeFiles/
${DownloadKey}               owais.txt