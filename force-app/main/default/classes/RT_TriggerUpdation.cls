public class RT_TriggerUpdation{
    
    public void beforeInsert(List<Contact> newlist){
        
    }
    public void beforeUpdate(List<Contact> newlist, List<contact> oldlist){
        
    }
    public void beforeDelete(List<contact> oldlist){
       
    }
    public void afterInsert(List<Contact> newlist){ 
        execute(newlist);
    }
    
    public void afterUpdate(List<Contact> newlist, List<contact> oldlist){
        List<Contact> lstAll = new List<Contact>();
        lstAll.addAll(newlist);
        lstAll.addAll(oldlist);
        execute(lstAll);
    }
    
    public void afterDelete(List<contact> oldlist){
        execute( oldlist);
    }
    
    private void Execute(List<Contact> listContacts){
        map<id,Integer> mapContactsCount  =  new map<id,Integer>();
        
        List<id> contactCount  =  new List<id>();
        for(contact con : listContacts){
            if(con.AccountId != null)
            contactcount.add(con.AccountId);
        }
        
        for(Contact contcount: [select id,accountid from Contact where accountid  =:  contactcount]){
            if(mapContactsCount.containsKey(contcount.AccountId)){
                Integer count  =  mapContactsCount.get(contcount.AccountId);
                mapContactsCount.put(contcount.AccountId,count+1);
            }else
                mapContactscount.put(contcount.AccountId,1);
        }
        List<Account> actCount  =  new list<account>();            
        for(id accID : contactcount){
            if(!mapContactsCount.containskey(accID)){
                actCount.add(createAccount(accID, 0));
            }else{
                actCount.add(createAccount(accID, mapContactsCount.get(accId))); 
            }
        }
        if(!actCount.isEmpty()){
            UPDATE actCount;
        }
    }
    private Account createAccount(ID accId, Integer count){
        Account obj  =  new Account();
        obj.Id = accId;
        obj.ContactsCount__c = count;
        return obj;
    }
}