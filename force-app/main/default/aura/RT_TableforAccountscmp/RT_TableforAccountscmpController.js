({
    
	dosave : function(component, event, helper) {
		var action = component.get("c.createAccount");
        action.setParams({'acctobj':component.get('v.actobj')});
        action.setCallback(this,function(data){
            component.set('v.actId',data.getReturnValue())
        });
        $A.enqueueAction(action);
	}
})