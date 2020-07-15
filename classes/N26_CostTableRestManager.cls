@RestResource(urlMapping='/CostTable/*')
global with sharing class N26_CostTableRestManager {
    @HttpGet
    global static Cost_Table__c getCostTableByUUID() {
        RestRequest request = RestContext.request;
        //Grab the contactUUId from the end of the URL
        String contactUUId = request.requestURI.substring(
        request.requestURI.lastIndexOf('/')+1);
        
        Cost_Table__c costTable = new Cost_Table__c();
        
        //Get Country and Product Detail from Contact
        try{
        String objectName = System.Label.N26_Cost_Table_ObjName;  
        Schema.SObjectType sObj = Schema.getGlobalDescribe().get(objectName);
        Contact result =  N26_CostTable_SOQLQueryUtility.getContactDetail(contactUUId);
        String countryId = result.Country__c;
		String productId = result.Product__c;
        
        //Get Api Name of all Cost Table fields
        String fieldSetName = System.Label.N26_Cost_Table_FieldSet;
        
        //Storing field Set details
        List<Schema.FieldSetMember> fieldSets = sObj.getDescribe().fieldSets.getMap().get(fieldSetName).getFields();
        List<String> fields = new List<String>(); 
        for(Schema.FieldSetMember fieldMember : fieldSets){
            fields.add(fieldMember.getFieldPath());
        }
        
        //Quering field value which are part of Cost Table Field Set
        costTable =  Database.query('select ' + String.join(fields, ',')+ ' from ' +objectName+ ' where Country__c =:countryId AND Product__c=:productId limit 1');
         
        }
        catch(Exception e){
            return costTable;
        }
        return costTable;
    }

}