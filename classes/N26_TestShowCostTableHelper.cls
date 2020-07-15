@isTest(SeeAllData=false)
public class N26_TestShowCostTableHelper {
    
    @testSetup
    static void dataSetup() {
        sObject cont = N26_TestDataCreation.ContactTestDataMethod();
		Case cas = new Case(Status ='New', Priority = 'Medium', Origin = 'Email',ContactId=cont.Id);
        Insert cas;
    }
    
    @isTest
    public static void showCostTestMethod(){
        test.startTest();
        
        Case cas = [Select Id from case LIMIT 1];
    	
        //Positive check
        system.assertEquals(false,N26_ShowCostTableHelper.getFieldSetMember('Cost_Table__c',cas.Id).isError);
        //Negative check
        system.assertEquals(true,N26_ShowCostTableHelper.getFieldSetMember('Cost_Table__c','').isError);
        test.stopTest();
    }

}