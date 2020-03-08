import common;
import messages;
import schemas;
import ballerina/log;
import ballerina/http;

public function getProductList() returns @tainted messages:ProductList | error {
    http:Client clientEndpoint = productBaseEndpoint();

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
