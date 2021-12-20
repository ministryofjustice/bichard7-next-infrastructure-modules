#!/usr/bin/env python

import argparse
import pip


def install_package(package_name):
    pip.main(["install", package_name])


try:
    import requests
except ModuleNotFoundError:
    install_package("requests")
    import requests

try:
    import sonarqube
except ModuleNotFoundError:
    install_package("python-sonarqube-api")

"""
This script is used to change the password for a given username in sonarqube.
This is currently only for the admin user who's default password is  'admin'

To do this we require the 'python-sonarqube-api' api to establish a connection to the sonarqube API and update the password

The order we pass the values in is important

| Argument | Desc | Value |
|----------|-------|---------|
| "username" | The user to change the password for | String |
| "current_password" | The default or current password you want to change, default is currently 'admin' in sonar 8.8 | String |
| "new_password" | The password we wish to update to | String |
| "sonar_url" | The url of where the sonar instance is deployed to so we can connect to it's api | String |

Once we establish a connection to the API we run some HTTP requests to update the user's password
"""

from sonarqube import SonarQubeClient


class UpdatePasswordForUser(object):
    _args = None
    _conn = None

    def _parse_arguments(self):
        parser = argparse.ArgumentParser()
        parser.add_argument("username", type=str)
        parser.add_argument("current_password", type=str)
        parser.add_argument("new_password", type=str)
        parser.add_argument("sonar_url", type=str)

        self._args = parser.parse_args()

    def _connect_to_sonarqube(self):
        try:
            client = SonarQubeClient(
                sonarqube_url=self._args.sonar_url,
                username=self._args.username,
                password=self._args.current_password
            )
            client.users.change_user_password(
                login=self._args.username,
                password=self._args.new_password,
                previousPassword=self._args.current_password
            )
        except (requests.exceptions.ConnectionError, sonarqube.utils.exceptions.AuthError) as e:
            print(e)

    def run(self):
        self._parse_arguments()
        self._connect_to_sonarqube()


if __name__ == "__main__":
    runner = UpdatePasswordForUser()
    runner.run()
