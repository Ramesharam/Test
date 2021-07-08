({
	handleSearch : function(component, event, helper) {
		helper.Search(component,event);
	},
	keyCheck: function(component, event, helper){
    	console.log('----->',event.which); 
    	//let code = event.which;
    	//console.log('-code---->',code);
    	var that = this;
    	if(event.which == 13){
    		console.log('-code---->',event.which);
    		helper.Search(component,event);
    	}
    },
	
})