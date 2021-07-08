public class RT_TriggeronLeadHandler {
    public static Boolean isFirstTime = true;
    public void afterInsert(List<Lead> newlist){
        LeadInsertUpdate(newlist);
    }
    public void afterUpdate(list<Lead> newlist){
     
        LeadInsertUpdate(newlist);
    }
    
    private void LeadInsertUpdate(List<Lead> newlist){
                
        List<Lead> obj = new List<Lead>();
        for(Lead leadId : newlist){
            Lead LeadObject = new Lead();
            LeadObject.Id = leadId.id;
            LeadObject.Lead_Id__c = leadId.id;
            System.debug('---->>'+LeadObject+'<<---');
            obj.add(LeadObject);
        }
        system.debug('o----o-->'+obj);
        UPDATE obj;
    }
    
}