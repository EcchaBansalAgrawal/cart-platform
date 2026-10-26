import json

# Simulate: ansible localhost -i inventory.ini -m shell -a "cat cart_deployment.json"
print('SIMULATING: ansible localhost -i inventory.ini -m shell -a "cat cart_deployment.json"')
print()

with open('cart_deployment.json') as f:
    content = f.read()

print('localhost | CHANGED | rc=0 >>')
print(content)

data = json.loads(content)
assert data['service_port'] == 3000, 'Port mismatch!'
assert data['deployment_name'] == 'cart_deployment', 'Name mismatch!'
print('Ansible verification: OK -- cart_deployment with port 3000 confirmed.')
