({
	doInit : function(component, event, helper) {
        console.log("Inside Child");
        var record = component.get('v.record');
        var field = component.get('v.fields');
        component.set("v.valueField", record[field]);
	}
})