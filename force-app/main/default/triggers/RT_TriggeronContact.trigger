/* Company      :RaagviTech
* Date          :18/3/2019
* Author        :Ramesh
* Description   :Trigger function to add,delete and update name fields in object.
* History       :
* Trigger Name  :RT_TriggeronContact
* Param         :insert,update,delete
*/
Trigger RT_TriggeronContact on Contact (before insert,before update,before delete, after insert, after update, after delete) {
    RT_TriggeronContactHandler obj = new RT_TriggeronContactHandler();
    if(Trigger.isBefore){
        if(Trigger.isInsert){
             obj.beforeInsert(Trigger.new);
        }
        else if(trigger.isUpdate){
             obj.beforeUpdate(Trigger.new, Trigger.old);
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