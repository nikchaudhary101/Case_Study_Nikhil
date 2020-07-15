@isTest(SeeAllData=false)
private class N26_Test_CostTableRestManager {
    
    @isTest static void testGetCostById() {
        test.startTest();
        sObject cont = N26_TestDataCreation.ContactTestDataMethod();
        String recordId = cont.Id;
        // Set up a test request
        RestRequest request = new RestRequest();
        request.requestUri =
            'https://nikh-dev-ed.my.salesforce.com/services/apexrest/CostTable/'
            + recordId;
        request.httpMethod = 'GET';
        RestContext.request = request;
        // Call the method to test
        Cost_Table__c thisCost = N26_CostTableRestManager.getCostTableByUUID();
        // Verify results
        System.assert(thisCost != null);
        System.assertEquals('Free', thisCost.ATM_Fee_in_other_currencies__c);
        test.stopTest();
    }

}