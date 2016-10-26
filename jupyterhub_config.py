import os
import sys

c = get_config()

os.environ['LD_LIBRARY_PATH'] = '/usr/local/cuda/lib64:/usr/local/cuda/extras/CUPTI/lib64:/usr/local/nvidia/lib64/'

c.Spawner.env.update('LD_LIBRARY_PATH')

c.Spawner.env_keep.append('LD_LIBRARY_PATH')

c.JupyterHub.log_level = 10

c.JupyterHub.authenticator_class = 'oauthenticator.GitHubOAuthenticator'

c.Authenticator.whitelist = whitelist = set()

c.Authenticator.admin_users = admin = set()

join = os.path.join

here = os.path.dirname(__file__)

root = os.environ.get('OAUTHENTICATOR_DIR', here)

sys.path.insert(0, root)

with open(join(root, 'userlist')) as f:
    for line in f:
        if not line:
            continue

        parts = line.split(',')

        print('processing %s' % (parts,))

        name = parts[1]

        whitelist.add(name)

        if len(parts) > 4 and parts[4].strip() == 'admin':
            admin.add(name)

            print('added %s as admin' % name)

c.GitHubOAuthenticator.oauth_callback_url = os.environ['OAUTH_CALLBACK_URL']

ssl = '/etc/letsencrypt/'

keyfile = join(ssl, 'privkey.pem')

certfile = join(ssl, 'cert.pem')

if os.path.exists(keyfile):
    c.JupyterHub.ssl_key = keyfile

if os.path.exists(certfile):
    c.JupyterHub.ssl_cert = certfile
