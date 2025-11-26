# Load Balancer Project: Custom Response Headers

This directory contains the script necessary to configure Nginx on a web server instance to add a custom HTTP response header, which is essential for tracking traffic behind a load balancer.

## 0-custom_http_response_header

This script installs Nginx, and using the `add_header` directive, injects the following custom header into every HTTP response:

- **Header Name:** `X-Served-By`
- **Header Value:** The server's hostname (e.g., `[student-id]-web-01`).

This allows the user to see which specific backend server (web-01 or web-02) handled their request, proving the load balancer is correctly distributing traffic.
