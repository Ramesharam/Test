({
    
    doInit : function(component, event, helper) {		                
        helper.getDataHelper(component, event);
    },
    Edit : function(component,event,helper) {
        component.set('v.isEdit', "True");
        component.set('v.save', "false");
    },
    Save : function(component,event,helper){
        component.set('v.isEdit', "false");
        component.set('v.save', "True");
       	var upsertRecordAction = component.get('c.updateRecord');
        var record =JSON.stringify(component.get('v.mydata'));
        console.log("............_>>",component.get('v.mydata'));
       //if (!record.sobjectType) {
         //   record.sobjectType = component.get('v.ObjectName');
			//console.log("............_>>",record);
        //}
		var sobj= component.get('v.ObjectName');        
        upsertRecordAction.setParams({
            sObj : sobj,
            jsonObjArr: record
        });
        
        upsertRecordAction.setCallback(this, 
                                       function(response) {
                                           var state = response.getState();                            
                                           console.log("callback state: " + state);
                                           var toastEvent = $A.get("e.force:showToast");
                                           if (component.isValid() && state === "SUCCESS") {
                                               toastEvent.setParams({
                                                   "title": "Success!",
                                                   "message": "The record has been upserted successfully.",
                                                   "type": "success"
                                               });
                                               
                                               toastEvent.fire();
                                               $A.get('e.force:refreshView').fire();
                                           }
                                           else if (state === "ERROR") {
                                               var errorMessage = response.getError()[0].message;
                                               
                                               toastEvent.setParams({
                                                   "title": "Error",
                                                   "message": "The record was not saved. Error: " + errorMessage,
                                                   "type": "error"
                                               });
                                              toastEvent.fire();
                                                

                                           }
                                       }
                                      );
        $A.enqueueAction(upsertRecordAction);
    }
    
})