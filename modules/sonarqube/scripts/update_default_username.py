#!/usr/bin/env python

import argparse
import pip


def install_package(package_name):
    pip.main(["install", package_name])


try:
    import psycopg2
except ModuleNotFoundError:
    install_package("psycopg2")

"""
This script is used to change the default admin username in sonarqube from being 'admin'

To do this a number of values are required as well as the library 'psycopg2' to connect to the database

The order we pass the values in is important

| Argument | Desc | Value |
|----------|-------|---------|
| "new_admin_username" | The new username to change the admin user to | String |
| "default_username" | The default or current username you want to change, default is currently 'admin' in sonar 8.8 | String |
| "db_connection_host" | The url where the db is | String |
| "db_name" | The name of the database, the default is 'sonar' in sonar 8.8 | String |
| "db_username" | The username to access the database | String |
| "db_password" | The password to access the database | String |

Once we establish a connection to the database we run a simple UPDATE command and close our connection once done
"""


class UpdateDefaultUsername(object):
    _args = None
    _conn = None

    def _parse_arguments(self):
        parser = argparse.ArgumentParser()
        parser.add_argument("new_admin_username", type=str)
        parser.add_argument("default_username", type=str)
        parser.add_argument("db_connection_host", type=str)
        parser.add_argument("db_name", type=str)
        parser.add_argument("db_username", type=str)
        parser.add_argument("db_password", type=str)

        self._args = parser.parse_args()

    def _connect_to_db(self):
        try:
            self._conn = psycopg2.connect(
                dbname=self._args.db_name,
                user=self._args.db_username,
                password=self._args.db_password,
                host=self._args.db_connection_host,
                port='5432'
            )
        except psycopg2.OperationalError as e:
            print(str(e))
            exit(1)
        print("Connection established: ", self._conn)

    def _change_default_username(self):
        try:
            cursor = self._conn.cursor()
            cursor.execute("UPDATE users SET login='{new_login}' WHERE login='{default_login}'"
                           .format(new_login=self._args.new_admin_username, default_login=self._args.default_username))
            cursor.close()
        except psycopg2.OperationalError as e:
            print(str(e))
            exit(1)

    def _close_db_connection(self):
        try:
            self._conn.commit()
            self._conn.close()
        except psycopg2.OperationalError as e:
            print(str(e))
            exit(1)
        print("Successfully closed connection")

    def run(self):
        self._parse_arguments()
        self._connect_to_db()
        self._change_default_username()
        self._close_db_connection()


if __name__ == "__main__":
    runner = UpdateDefaultUsername()
    runner.run()
