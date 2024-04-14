[Metadata]    Author    Owais Jilani
*** Variables ***

&{ANALYST_USER}         USERNAME=autoanalyst    PASSWORD=#enc#_gAAAAABlnFi6symZHUKVfWwbByHHMiXSbbFSTzaax2mQG5Zv3jofBcAAx-M7dYgiKkTCahitT-ghBWFCpkRyW9XRJ4jyFLcZ_g==    FNAME=auto     LNAME=analyst    ROLE=ANALYST  EMAIL=auto@analyst.com
&{ANALYST2_USER}        USERNAME=standard_user1    PASSWORD=#enc#_gAAAAABljU3gL2ggbar_rgpwqUuMIjDPmLSzEa0TrqBq-YPejhG46PzPE6u3YZVYAfjthk0VffqAV620XT3Td-kkHQBKZ4_KNw==    FNAME=Aml     LNAME=Analyst    ROLE=ANALYST    EMAIL=testamlanalyst1@test.com
&{MANAGER_USER}         USERNAME=standard_user        PASSWORD=secret_sauce      FNAME=auto     LNAME=manager    ROLE=MANAGER    EMAIL=auto@manager.com
&{INVALID_USER}         USERNAME=autoinvalid       PASSWORD=#enc#_oWAISJ_Z8ZIFvwK9u22t6T1Opxoj6R3V1K4L9T0Gi5pHuOQGdvyUhua9-k7G00WNiUjrzn6pYxND0vl9ojVhsuPZ8hiI_rB==    FNAME=UNKNOWN     LNAME=    ROLE=MANAGER    EMAIL=auto@invalid.com
&{SUPERADMIN_USER}      USERNAME=auto.superadmin    PASSWORD=#enc#_gAAAAABljU3gL2ggbar_rgpwqUuMIjDPmLSzEa0TrqBq-YPejhG46PzPE6u3YZVYAfjthk0VffqAV620XT3Td-kkHQBKZ4_KNw==    FNAME=Auto     LNAME=Superadmin    ROLE=Super Admin    EMAIL=OwaisJilani@appname.com
