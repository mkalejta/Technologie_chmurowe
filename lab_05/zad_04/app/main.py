import os
from http.server import HTTPServer, BaseHTTPRequestHandler

PORT = int(os.environ.get("APP_PORT", 8000))

class SimpleHandler(BaseHTTPRequestHandler):
    def do_GET(self):
        self.send_response(200)
        self.end_headers()
        self.wfile.write(b"Hello from Python on Alpine!")

if __name__ == "__main__":
    server = HTTPServer(("", PORT), SimpleHandler)
    print(f"Server running on port {PORT}")
    server.serve_forever()
