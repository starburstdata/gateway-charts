import jwt
import datetime

private_key = open('./private_key.pem', 'r').read()
claims = {'sub': 'gateway-svc', 'nbf': int(datetime.datetime.timestamp(datetime.datetime.now())), 'exp': int(datetime.datetime.timestamp(datetime.datetime(9999, 12, 31, 0, 0)))}
encoded = jwt.encode(claims, private_key, algorithm="RS256")

f = open('./gateway.jwt', 'w')
f.write(encoded)
f.close()
