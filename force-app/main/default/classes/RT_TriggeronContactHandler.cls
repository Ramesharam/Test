/**
* Company		:RaagviTech
* Date			:18/3/2019
* Author		:Ramesh
* Description	:Trigger class to Insert Contacts names to the respective Objects.
* History		:
* Class Name	:RT_TriggeronContactHandler
*/
public class RT_TriggeronContactHandler {
    /* Method Name	:beforeInsert
    *  @param		:newList
    *  Description	:Method to pass argument to Insert the value in object    
    */
    public void beforeInsert(List<Contact> newlist){
        
    }
    /** Method Name	:beforeUpdate
    *  @param		:newList, oldList
    *  Description	:Method to pass argument to update the value in object    
    */
    public void beforeUpdate(List<Contact> newlist, LIst<contact> oldList){
        
    }
    /** Method Name	:beforeDelete
    *  @param		:oldList
    *  Description	:Method to pass argument to delete the value in object    
    */
    public void beforeDelete(LIst<contact> oldList){
        
    }
    /** Method Name	:afterInsert
    *  @param		:newList
    *  Description	:Method to pass argument to Insert the value in object    
    */
    public void afterInsert(List<Contact> newList){
        toInsertDeleteUpdate(newList);
    }
    /** Method Name	:afterUpdate
    *  @param		:newList,oldList
    *  Description	:Method to pass argument to Upadate the value in object    
    */
    public void afterUpdate(List<Contact> newList, List<contact> oldList){
        List <Contact> newListToExecute = new List<contact>();
        newListToExecute.addAll(newList);
        newListToExecute.addAll(oldList);
        toInsertDeleteUpdate(newListToExecute);
    }  
    /** Method Name	:afterDelete
    *  param		:oldList
    *  Description	:Method to pass argument to delete the value in object
    */																
    public void afterDelete(List<contact> oldList){
        toInsertDeleteUpdate(oldList);
    }
    /** Method Name	:toInsertDeleteUpdatecute
    *  param		:newListNames
    *  Description	:Method for doing Insertion, Deletion and Upadating the fields in object
    */
    private void toInsertDeleteUpdate(List<Contact> newListNames){
        Map<Id,String> mapAccountIdbyName  =  new Map<Id,String>();
                List<Id> listAccountIdbyName  =  new List<Id>();
        for(contact con : newListNames){
            if(con.AccountId != null){
                listAccountIdbyName.add(con.accountid);
            }
        }
        for(Contact contactName: [SELECT id,accountid,firstname,lastname 
									from Contact 
                                  	WHERE accountid  =:  listAccountIdbyName]){
            if(mapAccountIdbyName.containsKey(contactName.AccountId)){
                String conName  =  mapAccountIdbyName.get(contactName.AccountId);
                mapAccountIdbyName.put(contactName.AccountId,+conName+', '+contactName.FirstName+contactName.lastname);
            }else{
                mapAccountIdbyName.put(contactName.AccountId,contactName.FirstName+contactName.lastname);
            }
        }
        List<Account> listAccountId  =  new List<Account>();
        for(Id accId:listAccountIdbyName){
            if(!mapAccountIdbyName.containskey(accId))
                listAccountId.add(addNames(accid,''));
            else
                listAccountId.add(addNames(accid,mapAccountIdbyName.get(accid)+';'));
        }
        if(!listAccountId.isEmpty()){
            UPDATE listAccountId;
        }
    }
    /* Method Name	:addNames
    *  param		:accId, Names
    *  Description	:method is used to add names to the corresponding account    
    */
    Private Account addNames(Id AccId,String Names){
        Account accountObject  = new account();
        accountObject.Id  =  accId;
        accountObject.Contact_Name__c  =  Names;
        return(accountObject);
    }
}