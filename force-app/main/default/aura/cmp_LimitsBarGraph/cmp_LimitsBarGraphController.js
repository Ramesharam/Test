({
	init : function(component, event, helper) {
		
        var map = component.get("v.map");
        var list = component.get("v.appliedFilterList");
        
        var appliedFilterList = [];
        
        for(var key in map){
            if(list.includes(key)){
                appliedFilterList.push({key:key, value:map[key]});
            }
        }
        
        component.set("v.childFilterList",appliedFilterList);
        console.log('childFilterList>>>>>>>> ',component.get("v.childFilterList"));
	},
})