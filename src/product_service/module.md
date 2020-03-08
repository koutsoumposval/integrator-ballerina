# Product Service

This module integrates with product backend service.

### Product Backend Service
Base path for product backend service is: `http://product:8080/product` *

Integrated API Endpoints are:
```
GET  "/product"
GET  "/product/{id}"
POST "/product"
```

* assuming that product backend service lives in the same docker network based on
`docker-compose` configuration.