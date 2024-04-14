import mysql.connector

class MySqlDBUtility(object):

    def Connect_To_MySqlDB(self, host, db_user, db_password, db_name):
        try:
            connection = mysql.connector.connect(host=host,
                                                 user=db_user,
                                                 password=db_password,
                                                 database=db_name)
        except Exception as e:
            print(e)
        return connection

    def Create_Database(self, host, user, password, db_name, filepath):
        try:
            fh = open(filepath)
            sql = fh.read()
            connection = self.DBConnect(host, user, password, db_name)
            cursor = connection.cursor()
            print("Creating Database :" + db_name)
            for result in cursor.execute(sql, multi=True):
                print()
        except Exception as e:
            print(e)
        print("Database Created Successfully...")
        connection.close()
