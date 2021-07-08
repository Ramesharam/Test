public class ObjectLimitBarChartController {
    
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

    public with sharing class wrappObjectHighestLimit{
        @AuraEnabled
        public String label;
        @AuraEnabled
        public Decimal value;
        
        public wrappObjectHighestLimit(String  label, Decimal value){
            this.label = label;
            this.value = value;
            
        }
    }

    public with sharing class wrappData{
        @AuraEnabled
        public wrappObjectHighestLimit wrapObjwithMaxLimit;
        @AuraEnabled
        public Map<String,Decimal> chartData;
        
        public wrappData(wrappObjectHighestLimit wrapObjwithMaxLimit, Map<String,Decimal> chartData){
            this.wrapObjwithMaxLimit = wrapObjwithMaxLimit;
            this.chartData = chartData;
            
        }
    }
    
    public static Map<String, Schema.sObjectType> globalDescribe {get {
        if(globalDescribe == null) {
            globalDescribe = Schema.getGlobalDescribe();
        }
        return globalDescribe;
    }set;}
    
    /**
    @MethodName     : getAllSobjects
    @Param          : 
    @return         : list<wrappersObjects>
    @Description    : get all Sobject name which user has access.
    **/
    @AuraEnabled(cacheable=true)
    public static String getallobjects(){
        List<wrappObjects> lstSobjects = new List<wrappObjects>();
        for(Schema.SObjectType obj : globalDescribe.values()){
            Schema.DescribeSObjectResult detail = obj.getDescribe();
            if(detail.isAccessible() && detail.isCreateable() && detail.isQueryable() && !detail.isCustomSetting() && detail.isSearchable() &&  detail.isUpdateable()) {
                lstSobjects.add(new wrappObjects(detail.getName(),detail.getLabel()));
            }   
        }      
        
        return JSON.serialize(lstSobjects);
    }
    
    
    //@AuraEnabled(cacheable=true)
    @AuraEnabled
    public static wrappData getObjectLimits(String objectName)
    {
        String queryString = ' Select Object_Type__c,Label__c,Usage__c from Object_Limit__c ';
        
        if(objectName != 'All' && String.isNotBlank(objectName)){
            queryString += ' Where Object_Type__c = \''+objectName+'\' ';
        }
        
        List<Object_Limit__c> objLimitList = Database.query(queryString);
        
        Map<String,Decimal> fieldLimittousageMap = new Map<String,Decimal>();
        
        Decimal maxLimitPercntValue = 0;
        for(Object_Limit__c obj : objLimitList)
        {
            maxLimitPercntValue = (obj.Usage__c > maxLimitPercntValue) ?  obj.Usage__c : maxLimitPercntValue;
            fieldLimittousageMap.put(obj.Label__c,obj.Usage__c);
        }

        wrappObjectHighestLimit wrapObjwithMaxLimit = new wrappObjectHighestLimit(objectName, maxLimitPercntValue);
        
        wrappData objWrap = new wrappData(wrapObjwithMaxLimit, fieldLimittousageMap);

        return objWrap;
    }
    
}