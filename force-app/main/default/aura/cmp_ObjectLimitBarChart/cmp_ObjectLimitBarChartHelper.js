({
    getAllObjects : function(cmp, event){
        
        var options= [];
        
        let action = cmp.get('c.getallobjects');
        action.setCallback(this, function(res){
            var state = res.getState();
            if(state === 'SUCCESS'){
                var res = res.getReturnValue();
                let objectsList = JSON.parse(res);
                objectsList.sort(function(a, b) {
                    var x = a.label.toLowerCase();
                    var y = b.label.toLowerCase();
                    return ((x < y) ? -1 : ((x > y) ? 1 : 0));
                });
                options.label = "All";
                options.value = "All";
                objectsList.unshift(options);
                cmp.set('v.options',objectsList);
                cmp.set('v.optionsOnSort',objectsList);
                
                var objOptionsMap = [];
                var objMap = {};
                
                objectsList.forEach( ele=> {
                    objMap[ele.value] = ele.label;
                })
                    objOptionsMap.push(objMap);
                    
                    cmp.set("v.objOptionsMap",JSON.parse(JSON.stringify(objOptionsMap[0])));
                    // console.log('objOptionsMap>>>>>> ',cmp.get("v.objOptionsMap"));
               }
                });
                    $A.enqueueAction(action);
                    
                }, 
                    
                    getAllSortFilters : function(cmp, event){
                        
                        var types = [
                            { value: "bar", label: "Bar" },
                            { value: "horizontalBar", label: "HorizontalBar" }
                        ];
                        cmp.set("v.graphTypes", types);
                        var sortbyFiters = [
                            { value: "Name", label: "Name" },
                            { value: "Percent", label: "Usage Percent" }
                        ];
                        cmp.set("v.sortFitersList", sortbyFiters);
                    },
                    
                    // check null values
                    isNotNull : function(value){
                        return  value != undefined &&  value != null && value != '' && value != 'All' ? true : false;
                    },
                    
                    getOnloadFilters : function(cmp, event, helper) {
                        var filterLabels;
                        var temp = [];
                        let action = cmp.get('c.getObjectLimits');
                        
                        action.setParams({
                            "objectName": 'Account'
                        });
                        action.setCallback(this, function(res){
                            var state = res.getState();
                            cmp.set("v.filterList",'');
                            if(state === 'SUCCESS'){ 
                                temp = res.getReturnValue();
                                filterLabels = JSON.parse(JSON.stringify(Object.keys(temp.chartData)));
                                cmp.set("v.filterList",filterLabels);
                                cmp.set("v.onloadObjectFilter",filterLabels);
                            }  
                        });
                        $A.enqueueAction(action);
                    }
                })