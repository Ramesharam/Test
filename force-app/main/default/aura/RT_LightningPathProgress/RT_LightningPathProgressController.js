({
    getAccounts: function (component, event, helper) {
        
        var selectedValue = event.getParam("detail").value;
        console.log("-------->>>",event.getParam("detail"));
        if(selectedValue== 'All'){
            var action = component.get('c.fetchAll');
        }
        else{
            var action = component.get('c.fetchAccount');
            action.setParams({
                count : selectedValue
            });
        }
        action.setCallback(this, function(response){
            var state = response.getState();
            console.log("--------<<<>>>>",state);
            
            if(state === 'SUCCESS'){
                var lstActRecords = [];
                for(var i=0; i<selectedValue ; i++){
                    
                    lstActRecords.push(response.getReturnValue()[i]);    
                }
                console.log('------>>>>>>>',lstActRecords);
                component.set('v.mydata', response.getReturnValue());
            }else{
                alert('ERROR');
            }
        });
        $A.enqueueAction(action);
        
        
        
        
    }
})