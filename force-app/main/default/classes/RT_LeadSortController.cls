public class RT_LeadSortController {
    @AuraEnabled
    public static List <Lead> getLeads() {
        List<Lead> myLead = [SELECT Id, name, Phone, Email, Priority__c FROM Lead WHERE Priority__c != null ORDER BY Priority__c DESC];
        system.debug('=======Lead'+myLead);
        return myLead;
    }
    @AuraEnabled
    public static List<String> getPickListValues(){
        List<String> pickListValuesList= new List<String>();
        Schema.DescribeFieldResult fieldResult = Lead.Priority__c.getDescribe();
        List<Schema.PicklistEntry> ple = fieldResult.getPicklistValues();
        for( Schema.PicklistEntry pickListVal : ple){
            pickListValuesList.add(pickListVal.getLabel());
        }     
        return pickListValuesList;
    }
    @AuraEnabled
    public static void updateRec(list<Lead> leadRec){
        system.debug('=====>'+leadRec);
        UPDATE leadRec;
    }
}