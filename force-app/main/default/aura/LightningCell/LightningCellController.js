({
    doInit : function(component, event, helper) {
        var record = component.get('v.mydata');
        var field = component.get('v.field');
        component.set("v.cellValue", record[field.fieldName]);
                
    },
    loadPicklist: function(component, event, helper){
        var field = component.get('v.field.fieldName');
        console.log("========>>>>>>>>pick",field);
        var action = component.get("c.getselectOptions");
        action.setParams({
            obj: component.get('v.obj'),
            fld: field
        });
        var opts = [];
        action.setCallback(this, function(response) {
            console.log("--------0000000>",response.getState);
            if (response.getState() == "SUCCESS") {
                var allValues = response.getReturnValue();
 
                if (allValues != undefined && allValues.length > 0) {
                    opts.push({
                        class: "optionClass",
                        label: "--- None ---",
                        value: ""
                    });
                }
                for (var i = 0; i < allValues.length; i++) {
                    opts.push({
                        class: "optionClass",
                        label: allValues[i],
                        value: allValues[i]
                    });
                }
                component.find(elementId).set("v.options", opts);
            }
        });
        $A.enqueueAction(action);
    },


   
    
    change : function(component, event, helper){
        var recData = component.get('v.mydata');
        var cell=component.get('v.cellValue');
        var field = component.get('v.field');

       recData[field.fieldName]=cell;
        component.set("v.mydata",recData);
         console.log("changing values.........>>",JSON.stringify(component.get('v.mydata') ));
    }
})