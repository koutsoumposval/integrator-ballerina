import ballerina/log;
import ballerina/http;

public function addProduct(int categoryId, string name) {
    http:Client clientEndpoint = productBaseEndpoint();

    json payload = {name: name, category_id: categoryId};

    log:printInfo(payload.toJsonString());

    var response = clientEndpoint->post("", payload);
}
