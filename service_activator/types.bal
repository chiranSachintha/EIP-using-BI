type Customer record {|
    string customerId;
    string customerName;
    decimal totalEligibleClaimAmount;
|};

type ClaimRequest record {|
    string customerId;
    string policyNumber;
    decimal claimAmount;
    string accidentType;
    string claimLocation;
    ClaimDate claimDate;
|};

type ClaimDate record {|
    string year;
    string month;
    string day;
|};

type Claim record {|
    "APPROVED"|"REJECTED"|"PENDING" status;
    string customerId;
    string policyNumber;
    decimal claimAmount;
    string accidentType;
    string claimLocation;
    ClaimDate claimDate;
|};

type ClaimHistory record {|
    string customerId;
    Claim[] claims;
|};
