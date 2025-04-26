import ballerina/http;

final http:Client paypalClient = check new ("http://api-m.sandbox.paypal.com.balmock.io");