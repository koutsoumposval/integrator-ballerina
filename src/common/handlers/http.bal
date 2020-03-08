import ballerina/http;
import ballerina/log;

public function handleResponse(http:Response | error response) returns @tainted json {
    if (response is http:Response) {
        var msg = response.getJsonPayload();

        log:printInfo("Payload received: " + msg.toString());

        if (msg is json) {
            return msg;
        } else {
            log:printError("Invalid payload received:" + msg.reason());
        }
    } else {
        log:printError("Error when calling the backend: " + response.reason());
    }
}
