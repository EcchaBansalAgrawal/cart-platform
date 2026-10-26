# cart-platform

Shopping Cart Microservice – containerised & deployment-ready.

## Repository layout

| File | Purpose |
|---|---|
| `app.py` | Python HTTP microservice (port 8081) |
| `inventory.json` | Product inventory data |
| `Dockerfile` | Builds `retail-cart:1.0` image |
| `Jenkinsfile` | Declarative pipeline (Checkout → Lint → Docker Package) |
| `k8s-cart.yaml` | Kubernetes Deployment (2 replicas) + NodePort Service (30083) |
| `main.tf` | Terraform config – creates `cart_deployment` on port 3000 |
| `inventory.ini` | Ansible inventory (localhost) |

## Quick start

### Docker
```bash
docker build -t retail-cart:1.0 .
docker run -d -p 8081:8081 --name retail-cart retail-cart:1.0
curl http://localhost:8081/healthz
```

### Kubernetes
```bash
kubectl apply -f k8s-cart.yaml
kubectl get pods -l tier=cart
kubectl get svc cart-service
```

### Terraform
```bash
terraform init
terraform apply -auto-approve
```

### Ansible ad-hoc verify
```bash
ansible localhost -i inventory.ini -m shell -a "cat cart_deployment.json"
```

## Git workflow
```
main
 └── release-cart-v1   (feature branch → merged → tagged cart-v1.0.0)
```
