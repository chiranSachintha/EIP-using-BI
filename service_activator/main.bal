import ballerina/http;

listener http:Listener httpListener = new (port = 8080);

service /api/v1 on httpListener {
    isolated resource function post claim(ClaimRequest claimRequest) returns decimal|error {
        ClaimHistory claimHostory = check claimHistory->/claims/[claimRequest.customerId]/claims\.json();
        Customer customer = check customerDetails->/customers/[claimRequest.customerId]/details\.json();
        return calculateClaimAmount(claimRequest, claimHostory, customer.totalEligibleClaimAmount);
    }
}

isolated function calculateClaimAmount(ClaimRequest claimRequest, ClaimHistory claimHistory, decimal totalElegibleAmount) returns decimal {
    decimal totalClaimedAmount = from var {claimAmount, claimDate, status} in claimHistory.claims
        where claimDate.year == claimRequest.claimDate.year && status == "APPROVED"
        collect sum(claimAmount);
    decimal remainingAmount = totalElegibleAmount - totalClaimedAmount;
    return decimal:max(remainingAmount, claimRequest.claimAmount * 0.2);
}
