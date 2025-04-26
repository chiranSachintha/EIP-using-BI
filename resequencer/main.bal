import ballerina/http;

listener http:Listener httpListener = new (port = 8080);

service /api/v1 on httpListener {
    resource function post employees/[string emoloyeeId]/approval(Approval approvalReq) returns error? {
        map<Approval[]> incompleteApprovals = {};
        Approval[]? approvals = incompleteApprovals[emoloyeeId];
        if approvals == () {
            incompleteApprovals[emoloyeeId] = [approvalReq];
            return;
        }
        approvals.push(approvalReq);
        if approvals.length() < 3 {

            return;
        }
        from Approval approval in approvals
        order by approval.leadLevel
        do {
            json jsonResult = check hrClient->/promotions/employees/[emoloyeeId]/approval.post(approval, targetType = json);
        };
        Approval[] remove = incompleteApprovals.remove(emoloyeeId);
    }
}
