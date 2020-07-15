@isTest(seealldata=false)
public class N26_TestDataCreation {
    
    public static sObject ContactTestDataMethod(){ 
        Product2 prod = new Product2(Name = 'Metal');
        Country__c con = new Country__c(Name = 'UK');
        insert con;
        insert prod;
        
        Cost_Table__c conTable = new Cost_Table__c(Country__c = con.Id,Product__c = prod.Id,Card_Replacement_Cost__c = 45.000,ATM_Fee_in_other_currencies__c = 'Free');
        insert conTable;
        
        Contact cont= new Contact(LastName='Test User',Country__c = con.Id,Product__c = prod.Id);
        insert cont;
        
        return cont;        
    }
}