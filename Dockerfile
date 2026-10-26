# retail-cart:1.0
# Shopping Cart Microservice – Docker image

FROM python:3.11-slim

LABEL maintainer="cart-team" \
      version="1.0" \
      description="Shopping Cart Microservice"

WORKDIR /app

# Copy application files
COPY app.py        ./app.py
COPY inventory.json ./inventory.json

# Expose the service port
EXPOSE 8081

# Healthcheck – verifies /healthz responds 200
HEALTHCHECK --interval=15s --timeout=5s --start-period=5s --retries=3 \
    CMD python3 -c "import urllib.request; urllib.request.urlopen('http://localhost:8081/healthz')" || exit 1

# Print startup banner then serve
CMD ["python3", "app.py"]
