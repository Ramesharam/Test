public class EntityLimitsResponseController {
    
    public with sharing class wrappObjects{
        @AuraEnabled
        public String value;
        @AuraEnabled
        public String label;
        
        public wrappObjects(String  value, String label){
            this.value = value;
            this.label = label;
            
        }
    }
    
    // globalDescribe get set
    public static Map<String, Schema.sObjectType> globalDescribe {get {
        if(globalDescribe == null) {
            globalDescribe = Schema.getGlobalDescribe();
        }
        return globalDescribe;
    }set;}
    
    public static void getallobjects(){
        List<wrappObjects> lstSobjects = new List<wrappObjects>();
        for(Schema.SObjectType obj : globalDescribe.values()){
            Schema.DescribeSObjectResult detail = obj.getDescribe();
            if(detail.isAccessible() && detail.isCreateable() && detail.isQueryable() && !detail.isCustomSetting() && detail.isSearchable() &&  detail.isUpdateable()) {
                lstSobjects.add(new wrappObjects(detail.getName(),detail.getLabel()));
            }   
        }  
        
        List<Object_Limit__c> objectLimitsList = new List<Object_Limit__c>();
        for(wrappObjects wrapObj : lstSobjects){
            if(Test.isRunningTest()){
                objectLimitsList.addAll(getObjectLimits('Account', 'Account'));
            }else{
                objectLimitsList.addAll(getObjectLimits(wrapObj.value, wrapObj.label));
			}
        }
        
        INSERT objectLimitsList;
    }
    
    public static List<Object_Limit__c> getObjectLimits(String objectName, String objectLabel){ 
        
        // Http for tooling API
        HttpRequest req = new HttpRequest();
        req.setHeader('Authorization', 'Bearer ' + UserInfo.getSessionID());
        //req.setHeader('Content-Type', 'application/json');    
        req.setEndpoint(URL.getSalesforceBaseUrl().toExternalForm() + '/services/data/v41.0/tooling/query/?q=SELECT+Type,+Label,+Remaining,+Max,+EntityDefinitionid+FROM+EntityLimit+where+EntityDefinitionid+=\''+objectName+'\'' );
        req.setMethod('GET');
        Http h = new Http();
        HttpResponse res = h.send(req);
        
        Map<String, Object> responseMap = (Map<String, Object>) JSON.deserializeUntyped(res.getBody());
        
        List<Object> dataMap = (List<Object>) responseMap.get('records'); 
        
        List<Object_Limit__c> limitList = new List<Object_Limit__c>();  
        for(Object objEntity : dataMap){
            Map<String, Object> newCast = (Map<String, Object>)objEntity;
            Object_Limit__c objectlimit = new Object_Limit__c();
            objectlimit.Object_Type__c = objectLabel;
            objectlimit.Label__c = String.valueOf(newCast.get('Label'));
            objectlimit.Type__c = String.valueOf(newCast.get('Type'));
            objectlimit.Max__c = Integer.valueOf(newCast.get('Max'));
            objectlimit.Remaining__c = Integer.valueOf(newCast.get('Remaining'));
            limitList.add(objectlimit);
        }
        
        return limitList;
    }
    
}