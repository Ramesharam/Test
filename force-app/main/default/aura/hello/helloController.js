({
    init : function(component, event, helper) {
        //var recId = compnent.get('v.recordId');
        var pageReference = {
            type: 'standard__component',
            attributes: {
                componentName: 'c__helloTarget',
            },
            state: {
                "c__firstname": "John",
                "c__lastname":"recId"
            }
        };
        component.set("v.pageReference", pageReference);
     },
     handleClick: function(component, event, helper) {
        var navService = component.find("navService");
        var pageReference = component.get("v.pageReference");
        console.log('test');
        console.log('test');
        console.log('test');
        console.log('test');
        console.log('test');
        console.log('test');
        console.log('test');
        console.log('test');
        console.log('test');
        console.log('test');
        console.log('test');
        event.preventDefault();
        navService.navigate(pageReference);
    }
})