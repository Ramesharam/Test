({
    getAccounts: function(component) {
        var action = component.get('c.fetchAccount');
        action.setCallback(this, function(response){
            var state = response.getState();
            if(state === 'SUCCESS' && component.isValid()){
                var pageSize = component.get("v.pageSize");
                component.set('v.actdata', response.getReturnValue());
                component.set("v.totalRecords", component.get("v.actdata").length);
                component.set("v.startPage",0);
                component.set("v.endPage",pageSize-1);
               	var temp=component.get("v.actdata").length;
                component.set("v.totalPages",temp/pageSize);
                var PaginationList = [];
                for(var i=0; i< pageSize; i++){
                    if(component.get("v.actdata").length> i)
                        PaginationList.push(response.getReturnValue()[i]);    
                }
                component.set('v.mydata', PaginationList);
            }else{
                alert('ERROR');
            }
        });
        $A.enqueueAction(action);
    },
    
    next : function(component, event){
        var actlist = component.get("v.actdata");
        var end = component.get("v.endPage");
        var start = component.get("v.startPage");
        var pageSize = component.get("v.pageSize");
        var Paginationlist = [];
        var counter = 0;
        for(var i=end+1; i<end+pageSize+1; i++){
            if(actlist.length > i){
                Paginationlist.push(actlist[i]);
            }
            counter ++ ;
        }
        start = start + counter;
        end = end + counter;
        component.set("v.startPage",start);
        component.set("v.endPage",end);
        component.set('v.mydata', Paginationlist);
    },
    previous : function(component, event){
        var actlist = component.get("v.actdata");
        var end = component.get("v.endPage");
        var start = component.get("v.startPage");
        var pageSize = component.get("v.pageSize");
        var Paginationlist = [];
        var counter = 0;
        for(var i= start-pageSize; i < start ; i++){
            if(i > -1){
                Paginationlist.push(actlist[i]);
                counter ++;
            }else{
                start++;
            }
        }
        start = start - counter;
        end = end - counter;
        component.set("v.startPage",start);
        component.set("v.endPage",end);
        component.set('v.mydata', Paginationlist);
    },
    
    sortByField: function(component, field) {
        var sortAsc = component.get("v.sortAsc"),
            sortField = component.get("v.sortField"),
            records = component.get("v.mydata");
        sortAsc = field == sortField? !sortAsc: true;
        records.sort(function(a,b){
            var t1 = a[field] == b[field],
                t2 = a[field] > b[field];
            return t1? 0: (sortAsc?-1:1)*(t2?-1:1);
        });
        component.set("v.sortAsc", sortAsc);
        component.set("v.sortField", field);
        component.set("v.mydata", records);
    },
    
    SearchHelper: function(component, srcValue) {
        var allData = component.get("v.actdata");
        var finalResult = [];
        for(var i= 0; i < allData.length ; i++){
            if(allData[i].Name == srcValue.trim())
                finalResult.push(allData[i]);
        }
        component.set("v.mydata",finalResult);
    }

    
})