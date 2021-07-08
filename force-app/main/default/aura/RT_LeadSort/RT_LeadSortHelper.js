({
    getLead : function(component) {
        var action = component.get('c.getLeads');
        action.setCallback(this, function(actionResult) {
            var LeadRecord = JSON.parse(JSON.stringify(actionResult.getReturnValue()));
            this.sortingRecords(component, LeadRecord);
            
        });
        $A.enqueueAction(action);
        
        
        var picAction = component.get('c.getPickListValues');
        picAction.setCallback(this, function(response){
            //console.log('----->',response.getReturnValue());
            component.set('v.picklist',response.getReturnValue());
        });
        $A.enqueueAction(picAction);
        
    },
    
    sortingRecords : function(component, values){
        var LeadRecord = values;
        var listHigh = new Array();
        var listMedium = new Array();
        var listLow = new Array();
        console.log('lead-------->',LeadRecord.length);
        
        for(var i=0;i<LeadRecord.length; i++){
            if(LeadRecord[i].Priority__c == 'High'){
                listHigh.push(LeadRecord[i]);
            }else if(LeadRecord[i].Priority__c == 'Medium'){
                listMedium.push(LeadRecord[i]);
            }else if(LeadRecord[i].Priority__c == 'Low'){
                listLow.push(LeadRecord[i]);
            }
        }
        console.log('lead-------->',listHigh);
        
        listHigh.sort((a, b) => (a.Name.toLowerCase() > b.Name.toLowerCase()) ? 1 : (a.Name.toLowerCase() === b.Name.toLowerCase()) ? 1 : -1 )
        listMedium.sort((a, b) => (a.Name.toLowerCase() > b.Name.toLowerCase()) ? 1 : (a.Name.toLowerCase() === b.Name.toLowerCase()) ? 1 : -1 )
        listLow.sort((a, b) => (a.Name.toLowerCase() > b.Name.toLowerCase()) ? 1 : (a.Name.toLowerCase() === b.Name.toLowerCase()) ? 1 : -1 )
        console.log('listHigh====',listHigh);
        /*for(var i=0; i<(listHigh.length)-1; i++){
                for(var j=i+1; j<listHigh.length; j++){
                    if(listHigh[i].Name > listHigh[j].Name){
                        console.log('hhhhhhhhh');
                        let Temp =listHigh[j];
                        listHigh[j] = listHigh[i];
                        listHigh[i]= Temp;
                    }
                }
            }
            for(var i=0; i<(listLow.length)-1; i++){
                for(var j=i+1; j<listHigh.length; j++){
                    if(listLow[i].Name > listLow[j].Name){                    
                        console.log('mmmmmmmmmmmm');
                        let Temp =listLow[j];
                        listLow[j] = listLow[i];
                        listLow[i]= Temp;
                    }
                }
            }
            for(var i=0; i<(listMedium.length)-1; i++){
                for(var j=i+1; j<listHigh.length; j++){
                    if(listMedium[j] != undefined && listMedium[i].Name > listMedium[j].Name){
                        console.log('lllllllll');
                        let Temp =listMedium[j];
                        listMedium[j] = listMedium[i];
                        listMedium[i]= Temp;
                    }
                }
            }*/
        
        listHigh = listHigh.concat(listMedium);
        listHigh = listHigh.concat(listLow);
        
        
        // to filter priority null values
        /*for(let i=0; i<LeadRecord.length; i++){
                //console.log('---->>>>',LeadRecord[i].Priority__c);
                if(LeadRecord[i].Priority__c == undefined || LeadRecord[i].Priority__c == 'None' ){
                    // console.log('--1111-->>>>',LeadRecord[i]);
                    listHigh.push(LeadRecord[i]);
                }
            }*/
        //console.log('---map-->>>>', listHigh);
        component.set('v.leads', listHigh);
        
    },
    
    isNotNUll : function(cmp, value){
        return (value == undefined && value == '' && value == null && value == 'None') ? true : false;
    }
})