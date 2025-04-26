type RefundRequest record {|
    string request_id;
    string email;
    string client_id;
    string capture_id;
|};

type PaypalRespose record {|
    string status;
    string message;
|};