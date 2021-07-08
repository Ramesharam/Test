public class RT_OpportunityTriggerHandler {
    public static Boolean runOnce = true;
    public void beforeInsert(List<Opportunity> lstNewOpportunity){
        for(Opportunity oppObject : lstNewOpportunity){
            oppObject.External_Id__c = '4554546565555777';
            
        }
    }
    public void afterInsert(List<Opportunity> lstNewOpportunity){
        Set<String> setOpportunityIds = new Set<String>();
        for(Opportunity oppObjectId: lstNewOpportunity){
            setOpportunityIds.add(oppObjectId.External_Id__c);
        }
        System.debug('----->>'+setOpportunityIds);
        List<Lead> lstLeadRecords = new List<Lead>();
        for(Lead leadRecords : [SELECT Id, Name, Company, External_Id__c FROM 
                                Lead WHERE External_Id__c In : setOpportunityIds AND IsConverted = False] ){
            lstLeadRecords.add(leadRecords);
        }
        System.debug('===>>'+lstLeadRecords);
        if(lstLeadRecords.isEmpty()){
            System.debug('List is empty');
            Account actObject = new Account();
            actObject.Name ='Inlet';
            actObject.Industry ='Hardware';
            //INSERT actObject;
            
            Contact contactObject = new Contact();
            contactObject.LastName = 'Lewis';
            //INSERT contactObject;
        }  
        else{
            for(Lead leadOb : lstLeadRecords){
                Database.LeadConvert leadConvertion = new Database.LeadConvert();
                leadConvertion.setLeadId(leadOb.id);
                System.debug('=LeadId=>'+leadConvertion);
                LeadStatus convertStatus = [SELECT Id, MasterLabel FROM LeadStatus WHERE IsConverted=true LIMIT 1];
                leadConvertion.setConvertedStatus(convertStatus.MasterLabel);
                Database.LeadConvertResult lcr = Database.convertLead(leadConvertion);
                System.debug('=LeadLCRId=>'+lcr);
            }
            
           /* List<Account> lstAccountRecord = new List<Account>();
            for(Lead leadOb:lstLeadRecords){
                Account actObject = new Account();
                actObject.Name = leadOb.company;
                actObject.Industry = 'Automobile';
                lstAccountRecord.add(actObject);
            }
            INSERT lstAccountRecord;
            List<Contact> lstContactRecord = new List<Contact>();
            List<Lead> lstLeadRecord = new List<Lead>();
            for(Lead leadObj:lstLeadRecords){
                Contact conObject = new Contact();
                conObject.LastName = leadobj.Name;
                lstContactRecord.add(conObject);
                Lead leadRecord = new Lead();
                leadRecord.Id = leadObj.Id;
                leadRecord.Status = 'Closed - Converted';
                //leadRecord.IsConverted = True;
                lstLeadRecord.add(leadRecord);
            }
            INSERT lstContactRecord;
            UPDATE lstLeadRecord;*/
        }
    }
}