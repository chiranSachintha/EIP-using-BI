import ballerina/http;

final http:Client claimHistory = check new ("http://api.claimhistory.firebase.com.balmock.io");
final http:Client customerDetails = check new ("http://api.customerdetails.firebase.com.balmock.io");