import ballerina/config;
import ballerina/http;

public function productBaseEndpoint() returns http:Client {
    http:Client clientEndpoint = new (
    config:getAsString("services.product.host") + ":" +
    config:getAsString("services.product.port") +
    config:getAsString("services.product.basePath"),
    {
        retryConfig: {
            intervalInMillis: 3000,
            count: 3,
            backOffFactor: 2.0,
            maxWaitIntervalInMillis: 20000
        },
        timeoutInMillis: 2000
    });

    return clientEndpoint;
}

