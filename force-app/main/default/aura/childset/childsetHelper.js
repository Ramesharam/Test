({
	getDataHelper : function(component, event) {
        var recordId = component.get('v.recordId');
        var ObjectName = component.get('v.ObjectName');
        var fieldSetName = component.get('v.fieldSetName');
        var action = component.get("c.getAccRecords");
        //Set the Object parameters and Field Set name and RecordId
        action.setParams({
            strObjectName : ObjectName,
            strFieldSetName :fieldSetName,// 'account_fields',
            recordId : recordId
        });
        action.setCallback(this, function(response){
            var state = response.getState();
            if(state === 'SUCCESS'){
                component.set("v.mycolumns", response.getReturnValue().lstDataTableColumns);
                component.set("v.mydata", response.getReturnValue().lstDataTableData);  
                console.log('------>',response.getReturnValue().lstDataTableColumns);
               console.log('------>',response.getReturnValue().lstDataTableData);

            }else if (state === 'ERROR'){
                var errors = response.getError();
                if (errors) {
                    if (errors[0] && errors[0].message) {
                        console.log("Error message: " +
                                    errors[0].message);
                    }
                } else {
                    console.log("Unknown error");
                }
            }else{
                console.log('Something went wrong, Please check with your admin');
            }
        });
        $A.enqueueAction(action);	
    }
})