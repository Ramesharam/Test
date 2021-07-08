({
    getValues : function(component, event){
		var fieldValues = component.get('v.fieldValues');
        var sObjectName = component.get('v.sObjectName');
        var recordId = component.get('v.recordId');
        var action = component.get('c.FetchData');
        var fields = fieldValues.split(',');
        action.setParams({
            fieldValues : fieldValues,
            sObjectName : sObjectName,
            record : recordId
        });
        action.setCallback(this, function(response){
            var fetchedData = response.getReturnValue();
            component.set('v.actName',fetchedData.Name);
            component.set('v.record',fetchedData);
            component.set('v.fieldList',fields);
            var fieldNames =[];
                        console.log("-fields-=+>>",fields);

            for(var i=0; i<fields.length;i++){
                            console.log("----------",fields[i].trim());

                fieldNames.add(fields[i].trim());
                                            console.log("-----++++++++-----");

            }  
            console.log("-fields-=+>>",fields);
                        console.log("-size-=+>>",fieldNames);

            component.set('v.fieldValues',fields.trim());
            console.log("--=+>>",component.get('v.fieldValues'));
            console.log("record--=+>>",component.get('v.record'));

        });
        $A.enqueueAction(action);
	}
})