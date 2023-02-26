# -*- encoding: utf-8 -*-
'''
First, install the latest release of Python wrapper: $ pip install ovh
'''
import os
import json
import ovh
import ast
import requests
import datetime
import gzip
from dotenv import load_dotenv

load_dotenv()

date = datetime.datetime.now().strftime("%Y-%m-%d")
web_service_name = os.environ.get('web_service_name')
web_db = os.environ.get('web_db')
# Instanciate an OVH Client.
# You can generate new credentials with full access to your account on
# the token creation page
client = ovh.Client(
    endpoint='ovh-eu',               # Endpoint of API OVH Europe (List of available endpoints)
    application_key=os.environ.get('application_key'),    # Application Key
    application_secret=os.environ.get('application_secret'), # Application Secret
    consumer_key=os.environ.get('consumer_key'),       # Consumer Key
)

result = client.get(f"/hosting/web/{web_service_name}/database/{web_db}/dump")
db_list = ast.literal_eval(json.dumps(result, indent=4))
last_db = sorted(db_list, reverse=True)[0]


result_url_dl_db = client.get(f"/hosting/web/{web_service_name}/database/{web_db}/dump/{last_db}")
url_dl_db = result_url_dl_db['url']
dl_db = requests.get(url_dl_db)
if dl_db.status_code == 200:
    with open("wp_{}.gz".format(date), 'wb') as f:
        f.write(dl_db.content)
else:
    print('La requête a échoué avec le code de statut :', dl_db.status_code)

with gzip.open("wp_{}.gz".format(date), 'rb') as f_in:
    with open("wp_{}.sql".format(date), 'wb') as f_out:
        f_out.write(f_in.read())

os.remove("wp_{}.gz".format(date))