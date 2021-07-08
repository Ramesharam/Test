/*   TriggerName       : RT_FinanceRequestTrigger
    * CreatedOn        : 30/Apr/2019
    * LastModifiedOn   : 03/May/2017
    * CreatededBy      : Ramesh
    * ModifiedBy       : Ramesh
    * Description      : Trigger to load case comments and attachments to Finance_req custom object
*/

trigger RT_FinanceRequestTrigger on Finance_Req__c (before insert, after insert, before update, after update) {
    RT_FinanceRequestTriggerHandler obj = new RT_FinanceRequestTriggerHandler();
    if(Trigger.isBefore){
        System.debug('beforeInsert');
        if(Trigger.isInsert){
            // if(RT_casePopulateInCustomObjectHandler.isFirstTime){
            //  RT_casePopulateInCustomObjectHandler.isFirstTime=False;
            System.debug('afterInsert');
            obj.beforeInsert(Trigger.new);
            // }
        }
        
        // if(Trigger.isInsert){
        // obj.beforeInsert(Trigger.new);
        //}
        else if(trigger.isUpdate){
            
            //if(RT_casePopulateInCustomObjectHandler.isFirstTime){
            // RT_casePopulateInCustomObjectHandler.isFirstTime=False;
            System.debug('before update');
            obj.beforeUpdate(Trigger.new);
        }
        
    }
    
    else{
        if(Trigger.isInsert){
            //  if(RT_casePopulateInCustomObjectHandler.isFirstTime){
            //RT_casePopulateInCustomObjectHandler.isFirstTime=False;
            System.debug('afterInsert');
            obj.afterInsert(Trigger.new);
            //   }
        }
        if(trigger.isUpdate){
            System.debug('afterUpdate');
            obj.afterUpdate(Trigger.new);
        }
        
    }
    
}