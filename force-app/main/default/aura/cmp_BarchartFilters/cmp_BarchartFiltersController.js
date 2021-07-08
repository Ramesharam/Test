({	
    handleScriptLoad : function(cmp, event, helper) {
        
        var isObjChange = cmp.get("v.isObjChange"); 
        var onloadObjectFilter = cmp.get("v.onloadObjectFilter");
        var sortedByLimitObjects = cmp.get("v.sortedByLimitObjects");
        
        var temp = [];
        var selectedObjectName = JSON.parse(JSON.stringify(cmp.get("v.sObjectName")));
        
        if(selectedObjectName != 'All')
        {
            let action = cmp.get('c.getObjectLimits');
            
            action.setParams({
                "objectName": selectedObjectName
            });
            
            //action.setStorable();
            action.setCallback(this, function(response){
                if(response.getState() === 'SUCCESS' && response.getReturnValue()){
                    temp = response.getReturnValue();
                    
                    if(cmp.get("v.isGetUsage")){
                        sortedByLimitObjects.push(temp.wrapObjwithMaxLimit);
                        cmp.set("v.sortedByLimitObjects",sortedByLimitObjects);
                    }
                    
                    var filterLabels = JSON.parse(JSON.stringify(Object.keys(temp.chartData)));
                    
                    cmp.set("v.dataMap",temp.chartData);
                    
                    // True When Any Object is Selected
                    if(isObjChange){
                        cmp.set("v.filterList",'');
                        cmp.set("v.appliedFilterList",filterLabels);
                        cmp.set("v.filterList",filterLabels);
                    }
                    // True when Select Object is All/null on page load
                    else if(!cmp.get("v.isOnloadFilterApplied")){
                        cmp.set("v.filterList",onloadObjectFilter);
                    }
                    
                    helper.matchSelectedFilter(cmp, event, helper);
                }
            });      
            
            $A.enqueueAction(action);	
        }
    },
    
    handleFilterChange : function(cmp, event, helper) {
        helper.matchSelectedFilter(cmp, event, helper);
    },
    
})