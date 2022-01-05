import json
import os
import sys

def is_https(server):
    return server['https']

def cert_missing(domain_name):
    chain_exists = os.path.exists("/etc/letsencrypt/live/{}/fullchain.pem".format(domain_name))
    private_exists = os.path.exists("/etc/letsencrypt/live/{}/privkey.pem".format(domain_name))
    return not (chain_exists and private_exists)

def missing_certs():
    with open("servers.json") as f:
        servers_input = json.loads(f.read())
        https_servers = filter(is_https, servers_input)
        https_server_names = map(lambda https_server: https_server['server_name'], https_servers)
        return list(filter(cert_missing, https_server_names))
