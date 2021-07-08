({
	doInit : function(component, event, helper) {
		console.log('Doinit---');
		component.set('v.columns', [
            {label: 'Id', fieldName: 'Id', type: 'text'},
			{label: 'Subject', fieldName: 'Subject', type: 'text'}]);
		var ShowResultValue = event.getParam("topicName");
		console.log('==ShowResultValue====>',ShowResultValue);
		var action = component.get('c.fetchTasks');
		action.setParams({ topicName : ShowResultValue});
		action.setCallback(this, function(response){
			var data = response.getReturnValue();
			console.log('======>',JSON.parse(JSON.stringify(data)));
			component.set("v.data", data);
		});
		$A.enqueueAction(action);
	}
})