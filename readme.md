# Ballerina Integrator

This is part of the ddd-playground project.

The project consists of many dockerised services written in different languages and exposing APIs.

An integrator component written in Ballerina lang will expose transformed and combined data of those APIs.

## Content

The application is the Integrator and it is written in Ballerina lang.

Base path of integrator is: `http://localhost:9090`

### Product Endpoints
API Endpoints available are:
```
GET  "/product"
GET  "/product/{id}"
POST "/product"
```
In details
```
curl --location --request GET "http://localhost:9090/product"

{
   "data":[
      {
         "id":1,
         "name":"Red Chair",
         "categoryId":1
      },
      {
         "id":2,
         "name":"Blue Table",
         "categoryId":2
      },
      {
         "id":3,
         "name":"Yellow Carpet",
         "categoryId":3
      }
   ],
   "meta":{
      "count":3,
      "page":1,
      "pageSize":3
   }
}
```

### Get specific product

```
curl --location --request GET 'http://localhost:9090/product/2'

{
   "id":2,
   "name":"Blue Table",
   "categoryId":2
}
```

### Create a new product

```
curl --location --request POST 'http://localhost:9090/product' -d '{"name":"Yellow Chair", "category_id":1}'

{
 "id":4,
 "name":"Yellow Chair",
 "categoryId":1
}
```
### Configuration
There is a `ballerina.conf.dist` available.
Create a new `ballerina.conf` with your configuration preferences.

### Start
```
make start
```

### Stop
```
make stop
```