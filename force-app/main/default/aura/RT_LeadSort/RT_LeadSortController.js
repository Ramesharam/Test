({
	doInit : function(component, event, helper) {
		helper.getLead(component); 
	},
    
    sortRecords : function(component, event, helper){
		var changedList = component.get('v.leads');
		console.log('+++====>',changedList);
        var action = component.get("c.updateRec");
        action.setParams({"leadRec": component.get("v.leads")});
        $A.enqueueAction(action);
        helper.sortingRecords(component, changedList);
    }
})