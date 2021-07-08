public class LightningDataTableController {
    
    
    @AuraEnabled
    public static void upsertRecord(String recordToUpsert)  {
        system.debug('++++====>>Inside upsert'+recordToUpsert);
        //upsert recordToUpsert;
    }
    @AuraEnabled
    public static String updateRecord(String sObj, String jsonObjArr) {
        List<SObject> objs;
        try {
            //System.debug('jsonObjArr::::::'+jsonObjArr);
            Type listType = Type.forName('List<' + sObj + '>');
            objs = (List<SObject>)JSON.deserialize(jsonObjArr, listType);
            system.debug('----------'+listType);
            //System.debug('objs::::>>'+objs);
            UPSERT objs;
        } catch (Exception e) {
            return '[{"data":' + jsonObjArr + ',"message":"' + e.getMessage() + '","cause":"' + e.getCause() + '","typeName":"' + e.getTypeName() + '"}]';
        }
        return 'success,' +objs[0].Id;
    }
    @AuraEnabled
    public static List < String > getselectOptions(sObject obj, String fld) {
        system.debug('objObject --->' + obj);
        system.debug('fld --->' + fld);
        List < String > allOpts = new list < String > ();
        // Get the object type of the SObject.
       Schema.sObjectType objType = obj.getSObjectType();
        
        // Describe the SObject using its object type.
        Schema.DescribeSObjectResult objDescribe = objType.getDescribe();
        
        // Get a map of fields for the SObject
        map < String, Schema.SObjectField > fieldMap = objDescribe.fields.getMap();
        
        // Get the list of picklist values for this field.
        list < Schema.PicklistEntry > values =fieldMap.get(fld).getDescribe().getPickListValues();
        
        // Add these values to the selectoption list.
        for (Schema.PicklistEntry a: values) {
            allOpts.add(a.getValue());
        }
        system.debug('allOpts ---->' + allOpts);
        allOpts.sort();
        return allOpts;
    }
    /*
Method Name	: getAccRecords
Purpose		: To get the wrapper of Columns and Headers
*/
    
    @AuraEnabled
    public static DataTableResponse getAccRecords(String strObjectName, String strFieldSetName, Id recordId){                
        
        //Get the fields from FieldSet
        Schema.SObjectType SObjectTypeObj = Schema.getGlobalDescribe().get(strObjectName);
        Schema.DescribeSObjectResult DescribeSObjectResultObj = SObjectTypeObj.getDescribe();            
        Schema.FieldSet fieldSetObj = DescribeSObjectResultObj.FieldSets.getMap().get(strFieldSetName);
        
        //To hold the table hearders 
        List<DataTableColumns> lstDataColumns = new List<DataTableColumns>();
        
        //Field to be queried - fetched from fieldset
        List<String> lstFieldsToQuery = new List<String>();
        
        //The final wrapper response to return to component
        DataTableResponse response = new DataTableResponse();
        
        for( Schema.FieldSetMember eachFieldSetMember : fieldSetObj.getFields() ){
            String dataType = String.valueOf(eachFieldSetMember.getType()).toLowerCase();
            //This way we can set the type of a column
            //We do not get the exact type from schema object which matches to lightning:datatable component structure
            if(dataType == 'datetime'){
                dataType = 'date';
            }
            //Create a wrapper instance and store label, fieldname and type.
            DataTableColumns datacolumns = new DataTableColumns( String.valueOf(eachFieldSetMember.getLabel()) , 
                                                                String.valueOf(eachFieldSetMember.getFieldPath()), 
                                                                String.valueOf(eachFieldSetMember.getType()).toLowerCase() );
            lstDataColumns.add(datacolumns);
            lstFieldsToQuery.add(String.valueOf(eachFieldSetMember.getFieldPath()));
        }
        
        //Form an SOQL to fetch the data - Set the wrapper instance and return as response
        if(! lstDataColumns.isEmpty()){            
            response.lstDataTableColumns = lstDataColumns;
            String query = ('SELECT ' + String.join(lstFieldsToQuery, ',') + ' FROM '+ strObjectName +' WHERE Id=: recordId');
            response.lstDataTableData = Database.query(query);
        }
        return response;
    }
    
    //Wrapper class to hold Columns with headers
    public class DataTableColumns {
        @AuraEnabled
        public String label {get;set;}
        @AuraEnabled       
        public String fieldName {get;set;}
        @AuraEnabled
        public String type {get;set;}
        
        //Create and set three variables label, fieldname and type as required by the lightning:datatable
        public DataTableColumns(String label, String fieldName, String type){
            this.label = label;
            this.fieldName = fieldName;
            this.type = type;            
        }
    }
    
    //Wrapper calss to hold response - This response is used in the lightning:datatable component
    public class DataTableResponse {
        @AuraEnabled
        public List<DataTableColumns> lstDataTableColumns {get;set;}
        @AuraEnabled
        public List<sObject> lstDataTableData {get;set;}                
        
        public DataTableResponse(){
            lstDataTableColumns = new List<DataTableColumns>();
            lstDataTableData = new List<sObject>();
        }
    }
}