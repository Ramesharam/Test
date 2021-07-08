({
    doInit: function (component, event, helper) {
        window.localStorage;
        var localStorageVarId = localStorage.getItem('localStorageId');
        //When the local storage has a value then this part will be executed from where it has left
        if (localStorageVarId) {
            component.set('v.jobId', localStorageVarId);
            component.set('v.isHideDelete', false);
            component.set('v.isHideAbort', true);
            component.set('v.isRefreshed', false);
            helper.displayMsg(component, event);
            let intervalTime = setInterval(function () {
                helper.displayMsg(component, event);
                var status = component.get('v.status');
                if (status == 'Completed' || status == 'Aborted' || status == 'Failed') {
                    clearTimeout(intervalTime);
                }
            }, 20000);
        }
    },
    delete: function (component, event, helper) {
        // console.log('-----Inside delete');
        component.set('v.isHideDelete', false);
        component.set('v.isHideAbort', true);
        component.set('v.isRefreshed', true);
        helper.handleDeleteLog(component, event, helper);
    },
    abort: function (component, event, helper) {
        component.set('v.isHideAbort', false);
        component.set('v.isHideDelete', true);
        helper.abortMsg(component, event, helper);
    }
})