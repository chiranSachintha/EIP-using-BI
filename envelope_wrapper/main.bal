import ballerina/http;

listener http:Listener httpListener = new (port = 8080);

service /paypal on httpListener {
    resource function post refund(RefundRequest refundReq) returns PaypalRespose|error {
        string authAssertionValue = getAuthAssertionValue(refundReq.client_id, refundReq.email);
        http:Request request = new http:Request();
        () var1 = request.addHeader("PayPal-Request-Id", refundReq.request_id);
        () var2 = request.addHeader("PayPal-Auth-Assertion", authAssertionValue);
        PaypalRespose|error unionResult = paypalClient->/v2/payments/captures/[refundReq.capture_id]/refund.post(request);
        return unionResult;
    }
}
