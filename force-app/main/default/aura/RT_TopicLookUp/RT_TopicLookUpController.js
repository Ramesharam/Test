({
	onfocus : function(component,event,helper){
		$A.util.addClass(component.find("mySpinner"), "slds-show");
		 var forOpen = component.find("searchRes");
			 $A.util.addClass(forOpen, 'slds-is-open');
			 $A.util.removeClass(forOpen, 'slds-is-close');
		 // Get Default 5 Records order by createdDate DESC  
		  var getInputkeyWord = '';
		  helper.searchHelper(component,event,getInputkeyWord);
	 },
	 onblur : function(component,event,helper){       
		 component.set("v.listOfSearchRecords", null );
		 var forclose = component.find("searchRes");
		 $A.util.addClass(forclose, 'slds-is-close');
		 $A.util.removeClass(forclose, 'slds-is-open');
	 },
	 keyPressController : function(component, event, helper) {
		// get the search Input keyword   
		  var getInputkeyWord = component.get("v.SearchKeyWord");
		// check if getInputKeyWord size id more then 0 then open the lookup result List and 
		// call the helper 
		// else close the lookup result List part.   
		 if( getInputkeyWord.length > 0 ){
			  var forOpen = component.find("searchRes");
				$A.util.addClass(forOpen, 'slds-is-open');
				$A.util.removeClass(forOpen, 'slds-is-close');
			 helper.searchHelper(component,event,getInputkeyWord);
		 }
		 else{  
			  component.set("v.listOfSearchRecords", null ); 
			  var forclose = component.find("searchRes");
				$A.util.addClass(forclose, 'slds-is-close');
				$A.util.removeClass(forclose, 'slds-is-open');
		   }
	 },
	 
   // function for clear the Record Selaction 
	 clear :function(component,event,heplper){
		  var pillTarget = component.find("lookup-pill");
		  var lookUpTarget = component.find("lookupField"); 
		 
		  $A.util.addClass(pillTarget, 'slds-hide');
		  $A.util.removeClass(pillTarget, 'slds-show');
		 
		  $A.util.addClass(lookUpTarget, 'slds-show');
		  $A.util.removeClass(lookUpTarget, 'slds-hide');
	   
		  component.set("v.SearchKeyWord",null);
		  component.set("v.listOfSearchRecords", null );
		  component.set("v.selectedRecord", {} );   
	 },
	 
   // This function call when the end User Select any record from the result list.   
	 handleComponentEvent : function(component, event, helper) {
	 // get the selected Account record from the COMPONETN event 	 
		var selectedTopicGetFromEvent = JSON.parse(JSON.stringify(event.getParam("recordByEvent")));
		// var rec = JSON.parse(JSON.stringify(component.get('v.selectedRecord')));
		// console.log('===>>>',rec);
		// if(rec.length > 0 && rec !=null && rec != undefined ){
		// 	console.log('=if==>>>',rec);
		// 	rec.filter(Boolean);
		// 	rec.push(selectedTopicGetFromEvent);
		// 	component.set("v.selectedRecord" , rec);
		// }else{
		// console.log('=else==>>>',rec);
		component.set("v.selectedRecord" , selectedTopicGetFromEvent);
		// }
		// console.log('=outside==>>>',rec);
		// var topicNames = JSON.parse(JSON.stringify(component.get('v.selectedRecord')));
		// console.log('topicNames topic=loop===>',selectedTopicGetFromEvent[1].Name); 
		// console.log('===>>>',topicNames.length);

		// var topics ='';
		// for(let i=0; i<topicNames.length; i++){
		// 	if (topicNames[i].Name === undefined || topicNames[i].Name == "") {
		// 		topicNames.splice(i, 1);
		// 		i--;
		// 	}
		// 	if(topics != null || topics != undefined && topicNames[i].Name != undefined){
		// 		topics = topics+' '+topicNames[i].Name;
		// 	}else if(topicNames[i].Name != undefined){
		// 		topics = topicNames[i].Name;
		// 	}

		// }
		// console.log('selected topic====>',topics); 
		var appEvent = $A.get("e.c:renderTableEvent");
        appEvent.setParams({"topicName" : selectedTopicGetFromEvent[0].Name });
        appEvent.fire();
		// var compEvent = component.getEvent("LoadEvent"); 
        //  compEvent.setParams({"topicName" : selectedTopicGetFromEvent.Name});  
		//  compEvent.fire();
		 console.log('ooooooo>>>');
		 var forclose = component.find("lookup-pill");
			$A.util.addClass(forclose, 'slds-show');
			$A.util.removeClass(forclose, 'slds-hide');
   
		 var forclose = component.find("searchRes");
			//$A.util.addClass(forclose, 'slds-is-close');
			//$A.util.removeClass(forclose, 'slds-is-open');
		 
		 var lookUpTarget = component.find("lookupField");
			 //$A.util.addClass(lookUpTarget, 'slds-hide');
			 //$A.util.removeClass(lookUpTarget, 'slds-show');  
	   
	 },
 })