({
    doInit : function(component, event, helper) {
        helper.getValues(component, event);
        
    },
    editRecord : function(component, event, helper) {
        console.log("Inside edit");
        var editRecordEvent = $A.get("e.force:editRecord");
        editRecordEvent.setParams({
            "recordId": component.get("v.recordId")
        });
        editRecordEvent.fire();
    }
})