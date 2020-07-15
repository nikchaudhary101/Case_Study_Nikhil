public class N26_CostTable_SOQLQueryUtility {
    public static Case getCaseDetail(string recordID ){
        Case cse= [Select ID, Contact.Product__c,Contact.Country__c from Case where Id =:recordID LIMIT 1];
        return cse;
    }
    
    public static Contact getContactDetail(string contactUUId ){
        Contact result =  [SELECT Product__c,Country__c FROM Contact WHERE Id = :contactUUId];
        return result;
    }
}