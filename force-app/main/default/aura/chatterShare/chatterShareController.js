({
    handleSelect: function (component, event, helper) {
        // This will contain the string of the "value" attribute of the selected
        // lightning:menuItem
        var selectedMenuItemValue = event.getParam("value");
        if(selectedMenuItemValue == 'CopyLink'){
            component.set('v.isShareWithGroup',false);
            component.set('v.isCopyLink',true);
            component.set('v.isShareWithFollowers',false);
            helper.handleCopyLink(component,event,helper);
        }else if(selectedMenuItemValue == 'ShareWithGroup'){
            component.set('v.isCopyLink',false);
            component.set('v.isShareWithGroup',true);
            component.set('v.isShareWithFollowers',false);
            helper.handleShareWithGroup(component,event,helper);
        }else if(selectedMenuItemValue == 'ShareWithFollowers'){
            component.set('v.isCopyLink',false);
            component.set('v.isShareWithGroup',false);
            component.set('v.isShareWithFollowers',true);
            helper.handleShareWithFollowers(component,event,helper);
        }
    },
    closeModel: function(component, event, helper) {
        // Set isModalOpen attribute to false  
        component.set("v.isCopyLink", false);
        component.set('v.isShareWithGroup',false);
        component.set('v.isShareWithFollowers',false);
        
    },
})