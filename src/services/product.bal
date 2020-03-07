import common;
import messages;
import schemas;
import ballerina/http;
import ballerina/log;

http:Client clientEndpoint = new ("http://localhost:8081/product", {
    retryConfig: {
        intervalInMillis: 3000,
        count: 3,
        backOffFactor: 2.0,
        maxWaitIntervalInMillis: 20000
    },
    timeoutInMillis: 2000
});

public function getProductList() returns @tainted messages:ProductList | error {
    var response = clientEndpoint->get("");

    json ress = common:handleResponse(response);

    if (ress is json[])
    {
        log:printInfo(ress.toJsonString());

        messages:ProductList productListMsg = {
            data: [],
            meta: {
                count: ress.length(),
                page: 1,
                pageSize: ress.length()
            }
        };

        foreach var res in ress {

            schemas:Product product = {
                id: <int>res.id,
                name: <string>res.name,
                categoryId: <int>res.category_id
            };

            productListMsg.data.push(product);
        }

        return productListMsg;
    } else {

        return error("Invalid response on product list retrieval");
    }
}

public function getProductById(int id) returns @tainted messages:Product | error {
    var response = clientEndpoint->get("/" + id.toString());

    json res = common:handleResponse(response);

    schemas:Product product = {
        id: <int>res.id,
        name: <string>res.name,
        categoryId: <int>res.category_id
    };

    messages:Product productMsg = {
        data: product
    };

    return productMsg;
}

public function addProduct(int categoryId, string name) {

    json payload = {name: name, category_id: categoryId};

    log:printInfo(payload.toJsonString());

    var response = clientEndpoint->post("", payload);
}
