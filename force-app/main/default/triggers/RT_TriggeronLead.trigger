trigger RT_TriggeronLead on Lead (before insert, After Insert, After Update) {
    RT_TriggeronLeadHandler obj = New RT_TriggeronLeadHandler();
    if(Trigger.isBefore){
        if(trigger.isUpdate){
            system.debug('update');
            // obj.beforeUpdate(Trigger.new, Trigger.old);
        }
        
    }
    else{
        if(Trigger.isInsert){
            system.debug('After--------------------------');
            obj.afterInsert(Trigger.new);
        }
        else if(trigger.isUpdate){
            if(RT_TriggeronLeadHandler.isFirstTime){
                RT_TriggeronLeadHandler.isFirstTime = False;
                System.debug('Update after................');
                obj.afterUpdate(trigger.new);
            }
            
        }
    }
    
}