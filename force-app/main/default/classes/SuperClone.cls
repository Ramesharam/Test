public class SuperClone {
    private static SuperCloneService service = new SuperCloneService();
    public class wrapperFields{
        public String FieldApiName;
        public String Label;
        public Boolean isWritable;
        public String DataType;
        public list<map<string,string>> picklistValue;
        
        public wrapperFields(String fieldApiName, String label, Boolean isWrite, String type, list<map<string,string>> picklistVal){
            this.FieldApiName= fieldApiName;
            this.Label = label;
            this.isWritable = isWrite;
            this.DataType = type;
            this.picklistValue = picklistVal;
        }
        public wrapperFields(String fieldApiName, String label, Boolean isWrite, String type){
            this.FieldApiName= fieldApiName;
            this.Label = label;
            this.isWritable = isWrite;
            this.DataType = type;
        }
    }
    public class wrapperValue{
        
        public List<wrapperFields> wrapperfields;
        public sObject record;
        
        public wrapperValue(List<wrapperFields> wrapperFields, sObject record){
            this.wrapperfields  = wrapperFields;
            this.record = record;
        }
    }
    @AuraEnabled
    public static Id doClone(Id parentId) {
        Id clonedId = service.doClone(parentId);
        return clonedId;
    }
    @AuraEnabled
    public static List<String> getFields(String parentId){
         Map <String, Schema.SObjectType> schemaMap = Schema.getGlobalDescribe();
        String objectAPIName = '';
        String keyPrefix = parentId.substring(0,3);
        for( Schema.SObjectType obj : schemaMap.Values() ){
            String prefix = obj.getDescribe().getKeyPrefix();
            if(prefix == keyPrefix){
                objectAPIName = obj.getDescribe().getName();
                break;
            }
        }
        Set <String> fieldMap = schemaMap.get(objectAPIName).getDescribe().fields.getMap().keySet();
        List<String> finalFields = new List<String>() ;
		finalFields.addAll(fieldMap);
        return  finalFields;
    }
}