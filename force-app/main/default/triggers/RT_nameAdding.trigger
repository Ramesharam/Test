trigger RT_nameAdding on Contact (before insert,before update,before delete, after insert, after update, after delete) {
    RT_TriggerUpdation obj = new RT_TriggerUpdation();
    if(Trigger.isBefore){
        if(Trigger.isInsert){
            obj.beforeInsert(Trigger.new);
        }
        else if(trigger.isUpdate){
            obj.beforeUpdate(trigger.new, Trigger.old);
        }
        else if(Trigger.isDelete){
            obj.beforeDelete(Trigger.old);
       }
    }
    else{
          if(Trigger.isInsert){
                obj.afterInsert(Trigger.new);
         }
        if(trigger.isUpdate){
            obj.afterUpdate(trigger.new, Trigger.old);
        }
        else if(Trigger.isDelete){
            
            obj.afterDelete(Trigger.old);
        }
    }
    
}