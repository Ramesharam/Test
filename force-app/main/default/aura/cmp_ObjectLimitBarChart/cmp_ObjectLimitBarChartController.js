({
    init : function(cmp, event, helper) {
        
        // Onload limit filters values 
        helper.getOnloadFilters(cmp, event, helper);
        // Sort filters values
        helper.getAllSortFilters(cmp, event);
        // Fetch all objects from org
        helper.getAllObjects(cmp, event);
    },
    
    handleObjectChange : function(cmp, event, helper) {
        
        // Dont fetch max percent usage data
        cmp.set("v.isGetUsage",false);
        
        var selectedObj = cmp.get("v.sObjectName");
        var objOptionsMap = cmp.get("v.objOptionsMap");
        
        if(!helper.isNotNull(selectedObj)){
            helper.getOnloadFilters(cmp, event, helper);
        }else{
            cmp.set("v.objectLabel",objOptionsMap[selectedObj]);
        }
    },
    
    handleSortBy : function(cmp, event, helper) {
        
        let objectsList = cmp.get('v.options');
        var sortNameType = cmp.get("v.sortNameType"); 
        let sortedByLimitObjects = cmp.get("v.sortedByLimitObjects");
        
        // Sort by Name
        if(sortNameType == 'Name'){
            objectsList.sort(function(a, b) {
                let w = a.label.toLowerCase();
                let x = b.label.toLowerCase();
                return ((w < x) ? -1 : ((w > x) ? 1 : 0));
            });
            cmp.set('v.optionsOnSort',objectsList);
            
        }
        // Sort by Percent
        else {
            cmp.set("v.isGetUsage",false);
            sortedByLimitObjects.sort(function(c, d) {
                let y = c.value;
                let z = d.value;
                return ((y > z) ? -1 : ((y < z) ? 1 : 0));
            });
            cmp.set('v.optionsOnPerSort',sortedByLimitObjects);
        }
        
    },
    
    handleFilterChange : function(cmp, event, helper) {
        
        cmp.set("v.isGetUsage",false);
        var appliedFilterList;
        
        var isChecked = event.getSource().get("v.checked");
        var flterVal = event.getSource().get("v.label");
        var index = event.getSource().get("v.name");
        
        var selectedObj = cmp.get("v.sObjectName");
        
        // To store selected filetrs for all objects onload
        if(!helper.isNotNull(selectedObj)){
            appliedFilterList = cmp.get('v.onloadObjectFilter');
        }
        // To store selected filetrs selected object
        else{
            appliedFilterList = cmp.get('v.appliedFilterList');
        }
        
        var element = appliedFilterList.indexOf(flterVal);
        
        if(isChecked){
            //if (element > -1) {
            //appliedFilterList.push(flterVal);
            appliedFilterList.splice(index, 0, flterVal);
            //}
        }else{
            if (element > -1) {
                appliedFilterList.splice(element, 1);
            }
        }
        
        var selectedObj = cmp.get("v.sObjectName");
        // to apply checked limit filters to all object onload
        if(!helper.isNotNull(selectedObj)){
            cmp.set('v.sObjectName','All');
            cmp.set("v.onloadObjectFilter",appliedFilterList);
            cmp.set("v.isOnloadFilterApplied",true);
        }
        // To store selected filetrs for selected object
        else{
            cmp.set("v.appliedFilterList",appliedFilterList);
        }
        
    }
})