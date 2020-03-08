import common;
import messages;
import schemas;
import ballerina/http;

public function getProductById(int id) returns @tainted messages:Product | error {
    http:Client clientEndpoint = productBaseEndpoint();

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
