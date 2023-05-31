import jwt
import datetime

from cryptography.hazmat.primitives import serialization as crypto_serialization
from cryptography.hazmat.primitives.asymmetric import rsa
from cryptography.hazmat.backends import default_backend as crypto_default_backend

key = rsa.generate_private_key(
    backend=crypto_default_backend(),
    public_exponent=65537,
    key_size=2048
)

private_key = key.private_bytes(
    crypto_serialization.Encoding.PEM,
    crypto_serialization.PrivateFormat.PKCS8,
    crypto_serialization.NoEncryption()
)

public_key = key.public_key().public_bytes(
    crypto_serialization.Encoding.PEM,
    crypto_serialization.PublicFormat.SubjectPublicKeyInfo,
)

claims = {'sub': 'gateway-svc', 'nbf': int(datetime.datetime.timestamp(datetime.datetime.now())), 'exp': int(datetime.datetime.timestamp(datetime.datetime(9999, 12, 31, 0, 0)))}
encoded = jwt.encode(claims, private_key, algorithm="RS256")
f = open('./private_key.pem', 'wb')
f.write(private_key)
f.close()
f = open('./public_key.pem', 'wb')
f.write(public_key)
f.close()
f = open('./gateway.jwt', 'w')
f.write(encoded)
f.close()
