import common;
import messages;
import schemas;
import services;
import ballerina/http;
import ballerina/log;
import ballerina/docker;

@docker:Expose {}
listener http:Listener productEP = new(9090);
@docker:Config {
    name: "product",
    tag: "v1.0"
}
@http:ServiceConfig {
    basePath: "/product"
}
service publisher on productEP {

    @http:ResourceConfig {
        methods: ["GET"],
        path: "/{id}"
    }
    resource function get(http:Caller caller, http:Request req,@tainted int id) {
        http:Response res = new;
        json responsePayload = {};

        messages:Product | error msg = services:getProductById(common:validateId(id));

        if (msg is messages:Product)
        {
            responsePayload = <json>json.constructFrom(msg);
        } else {

            log:printError(msg.reason());

            responsePayload = {
                "error": "Product cannot be retrieved"
            };
        }


        res.setJsonPayload(<@untainted>responsePayload);

        var result = caller->respond(res);

        log:printInfo("Get Product byId Response: " + responsePayload.toJsonString());
    }

    @http:ResourceConfig {
        methods: ["POST"],
        path: "/"
    }
    resource function add(http:Caller caller, http:Request req) {
        http:Response res = new;
        var requestPayload = req.getJsonPayload();
        json responsePayload = {};

        if (requestPayload is json) {

            services:addProduct(
            common:validateId(<int>requestPayload.categoryId),
            common:validateString(<string>requestPayload.name)
            );

            messages:ProductList | error msg = services:getProductList();

            if (msg is messages:ProductList)
            {
                schemas:Product[] lastProduct = msg.data.slice(msg.data.length() - 1, msg.data.length());

                responsePayload = {
                    "id": <int>lastProduct[0].id,
                    "name": <string>lastProduct[0].name,
                    "categoryId": <int>lastProduct[0].categoryId
                };
            }
        } else {
            res.statusCode = 400;
            responsePayload = {
                "error": "Invalid request payload"
            };
        }

        res.setJsonPayload(<@untainted>responsePayload);

        var result = caller->respond(res);

        log:printInfo("Add Product Response: " + responsePayload.toJsonString());
    }

    @http:ResourceConfig {
        methods: ["GET"],
        path: "/"
    }
    resource function getList(http:Caller caller, http:Request req) {
        http:Response res = new;
        json responsePayload = {};

        messages:ProductList | error msg = services:getProductList();

        if (msg is messages:ProductList)
        {
            responsePayload = <json>json.constructFrom(msg);
        } else {

            log:printError(msg.reason());

            responsePayload = {
                "error": "Product list cannot be retrieved"
            };
        }

        res.setJsonPayload(<@untainted>responsePayload);

        var result = caller->respond(res);

        log:printInfo("Get Product List Response: " + responsePayload.toJsonString());
    }
}


