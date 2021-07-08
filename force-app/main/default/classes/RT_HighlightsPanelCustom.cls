public class RT_HighlightsPanelCustom {
@AuraEnabled
    public static sObject FetchData( id record, String sObjectName, String fieldValues) {//Fetch data
        system.debug('-000000+==>'+fieldValues);
        String fetch = 'SELECT '+ fieldValues +' FROM '+ sObjectName +' WHERE Id =: record';
        System.debug('------->>'+fetch);
        SObject recordData = Database.query(fetch);
        System.debug('+++++++>>'+recordData);
        return recordData;

    }    

}