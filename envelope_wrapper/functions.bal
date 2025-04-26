isolated function getAuthAssertionValue(string client_id, string email) returns string {
    string encodedHeader = {alg: "none"}.toString().toBytes().toBase64();
    map<string> payload = {
        iss: client_id,
        payer_id: email
    };
    string encodedPayload = payload.toString().toBytes().toBase64();
    return string `${encodedHeader}.${encodedPayload}.`;
}
