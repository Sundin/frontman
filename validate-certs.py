import sys
from cert_utils import missing_certs

missing_certs = missing_certs()
if missing_certs:
    print("Missing certs: " + ",".join(missing_certs), file=sys.stderr)
    sys.exit(1)

sys.exit(0)
