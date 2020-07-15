public class N26_ShowCostTableHelper {
    
    @AuraEnabled(cacheable=true)
    public static FieldSetMemberWrapperClass getFieldSetMember(String obName ,String recordID){
        //List<FieldSetMemberWrapperClass> wrapperList = new List<FieldSetMemberWrapperClass>();
        FieldSetMemberWrapperClass wrapper = new FieldSetMemberWrapperClass();
        
        try{
        Case con =N26_CostTable_SOQLQueryUtility.getCaseDetail(recordID);
        String countryID = con.Contact.Country__c;
        String productID = con.Contact.Product__c;
        
        //Null check on countryID and productID
        if(countryID!=null && productID!=null){
        Schema.SObjectType sObj = Schema.getGlobalDescribe().get(obName);
            
        //Storing field Set name from where fields list to be showed is fetched.
        String fieldSetName = System.Label.N26_Cost_Table_FieldSet;
        
        //Storing field Set details
        List<Schema.FieldSetMember> fieldSets = sObj.getDescribe().fieldSets.getMap().get(fieldSetName).getFields();
        List<String> fields = new List<String>(); 
        for(Schema.FieldSetMember fieldMember : fieldSets){
            fields.add(fieldMember.getFieldPath());
        }
        
        //Quering field value which are part of Cost Table Field Set
        SObject objectRec =  Database.query('select ' + String.join(fields, ',')+ ' from ' +obName+ ' where Country__c =:countryID AND Product__c=:productID limit 1');
            wrapper.costTableId=String.valueOf(objectRec.get('Id'));
            wrapper.fieldSetValue=String.join(fields, ',');
        }
            else{wrapper.isError=True;}
        
        }
        catch(Exception e){
            wrapper.isError=True;
        }
        return wrapper;       
    }
    
    //Wrapper class to prepare response
    public class FieldSetMemberWrapperClass{
        @AuraEnabled
        public String costTableId{get;set;}
        @AuraEnabled
        public String fieldSetValue{get;set;}
        @AuraEnabled
        public Boolean isError{get;set;}
        
        public FieldSetMemberWrapperClass(){
            costTableId='';
            fieldSetValue='';
            isError=false;
        }     

    }
}