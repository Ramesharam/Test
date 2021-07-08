({
	doinit : function(component, event, helper) {
        console.log("---k------->>");
        var action = component.get('c.fetchContacts');
                console.log("---k------->>",action);
        action.setCallback(this, function(response){
                component.set('v.contactRecords', response.getReturnValue());
                
        });
        $A.enqueueAction(action);
    }
})