#!/usr/bin/env python3
"""
Shopping Cart Microservice
Retail Cart v1.0  –  prints "Shopping Cart Active" on startup.
"""

import json
import os
from http.server import BaseHTTPRequestHandler, HTTPServer

PORT = int(os.environ.get("PORT", 8081))

with open("inventory.json") as f:
    INVENTORY = json.load(f)


class CartHandler(BaseHTTPRequestHandler):
    def log_message(self, fmt, *args):  # suppress default access log noise
        pass

    def _send(self, code: int, body: dict):
        payload = json.dumps(body).encode()
        self.send_response(code)
        self.send_header("Content-Type", "application/json")
        self.send_header("Content-Length", str(len(payload)))
        self.end_headers()
        self.wfile.write(payload)

    def do_GET(self):
        if self.path == "/healthz":
            self._send(200, {"status": "ok", "service": "retail-cart", "version": "1.0"})
        elif self.path == "/inventory":
            self._send(200, INVENTORY)
        else:
            self._send(404, {"error": "not found"})


if __name__ == "__main__":
    print("Shopping Cart Active")
    server = HTTPServer(("0.0.0.0", PORT), CartHandler)
    print(f"Listening on port {PORT}")
    server.serve_forever()
