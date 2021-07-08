trigger RT_OpportunityTrigger on Opportunity (before insert, after insert) {
    RT_OpportunityTriggerHandler obj = new RT_OpportunityTriggerHandler();
    if(Trigger.isBefore){
        if(Trigger.isInsert){
            System.debug('Before Insert');
            obj.beforeInsert(Trigger.new);
        }
        else if(Trigger.isUpdate){}
        else if(Trigger.isDelete){}
    }
    else{
        if(Trigger.isInsert && RT_OpportunityTriggerHandler.runOnce){
            RT_OpportunityTriggerHandler.runOnce = false;
            System.debug('After Insert');
            obj.afterInsert(Trigger.new);
        }
        else if(Trigger.isUpdate){}
        else if(Trigger.isDelete){}
    }
}