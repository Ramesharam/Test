({
    doinit : function(component, event, helper) {
        
        helper.getAccounts(component);
    },
    createRecord : function (component, event, helper) {
        var createRecordEvent = $A.get("e.force:createRecord");
        createRecordEvent.setParams({
            "entityApiName": "Account"
        });
        createRecordEvent.fire();
    },
    sortByName : function(component, event, helper) {
        helper.sortByField(component, "Name");
    },
    sortByNumber: function(component, event, helper) {
        helper.sortByField(component, "AccountNumber");
    },
    sortByIndustry: function(component, event, helper) {
        helper.sortByField(component, "Industry");
    },
    
    newPopup : function(component, event, helper){
        var cmpTarget = component.find('Modalbox1');
        var cmpBack = component.find('Modalbackdrop');
        $A.util.addClass(cmpTarget, 'slds-fade-in-open');
        $A.util.addClass(cmpBack, 'slds-backdrop--open');
    },
    
    saveModal : function(component, event, helper){
        var regForm = component.get("v.accForm");
        var action = component.get("c.saveDetails");
        action.setParams({regForm1  : regForm});
        action.setCallback(this, function(response) {
            var state = response.getState();          
            if (state === "SUCCESS") {
                $A.get('e.force:refreshView').fire();
                var cmpTarget = component.find('Modalbox1');
                var cmpBack = component.find('Modalbackdrop');
                $A.util.removeClass(cmpBack,'slds-backdrop--open');
                $A.util.removeClass(cmpTarget, 'slds-fade-in-open');   
            }
        });
        $A.enqueueAction(action);
    },
    
    closeNewModal : function(component, event, helper){
        var cmpTarget = component.find('Modalbox1');
        var cmpBack = component.find('Modalbackdrop');
        $A.util.removeClass(cmpBack,'slds-backdrop--open');
        $A.util.removeClass(cmpTarget, 'slds-fade-in-open');
    },
  
    nextIndex: function (component, event, helper) {
        helper.next(component, event);
    },
    previous: function (component, event, helper) {
        helper.previous(component, event);
    },
    
    Search: function(component, event, helper) {
            helper.SearchHelper(component, component.get('v.searchString'));
    },
})