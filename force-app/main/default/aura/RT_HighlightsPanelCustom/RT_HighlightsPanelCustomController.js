({
   doInit : function(component, event, helper) {
        var fieldValues = component.get('v.fieldValues');
        var sObjectName = component.get('v.sObjectName');
        var recordId = component.get('v.recordId');
        var action = component.get('c.FetchData');
        var fields = fieldValues.split(',');
        console.log('---->',fields);
        action.setParams({
            fieldValues : fieldValues,
            sObjectName : sObjectName,
            record : recordId
        });
        action.setCallback(this, function(response){
            var fetchedData = response.getReturnValue();
                        console.log("in");

            component.set('v.actName',fetchedData.Name);
                                    console.log("in",component.get('v.actName'));

            component.set('v.record',fetchedData);
                                    console.log('000>>test>>>',component.get('v.record'));

           	component.set('v.fieldList',fields);
            			console.log("==jj==>>>",fieldValues);
            			console.log('000>>fieldList>>>',component.get('v.fieldList'));
			            component.set('v.fieldValues',fields);
        });
        $A.enqueueAction(action);
    }
})