({
    // it will delete the Apex logs and return Id
    handleDeleteLog: function (component, event, helper) {
        var that = this;
        var action = component.get("c.callBatchApex");
        action.setCallback(this, function (response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                var jobId = response.getReturnValue();
                component.set('v.jobId', jobId);
                localStorage.setItem('localStorageId', jobId);
            }
            // For Scheduling 20 Sec
            that.displayMsg(component, event);
            let intervalTime = setInterval(function () {
                that.displayMsg(component, event);
                var status = component.get('v.status');
                if (status == 'Completed' || status == 'Aborted' || status == 'Failed') {
                    clearTimeout(intervalTime);
                }
            }, 20000);
        });
        $A.enqueueAction(action);
    },
    // It will display the status of the job
    displayMsg: function (component, event) {
        var action = component.get("c.deleteJob");
        var jobId = localStorage.getItem('localStorageId');
        action.setParams({
            "jobId": jobId
        });
        action.setCallback(this, function (response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                var result = response.getReturnValue();
                var msg;
                if (result.Status == 'Holding') {
                    msg = 'The Status is Holding';
                    component.set('v.progress', 20);
                } else if (result.Status == 'Queued') {
                    msg = 'The Status is Queued';
                    component.set('v.progress', 40);
                } else if (result.Status == 'Preparing') {
                    msg = 'The Status is Preparing';
                    component.set('v.progress', 60);
                } else if (result.Status == 'Processing') {
                    msg = 'The Status is Processing';
                    component.set('v.progress', 80);
                } else if (result.Status == 'Aborted') {
                    msg = 'The Status is Aborted';
                    component.set('v.progress', 100);
                    localStorage.removeItem('localStorageId');
                } else if (result.Status == 'Completed') {
                    msg = 'The Status is Completed';
                    component.set('v.progress', 100);
                    component.set('v.isHideAbort', false);
                    component.set('v.isHideDelete', true);
                    component.set('v.showProgressBar', true);
                    localStorage.removeItem('localStorageId');
                } else {   // Its For Failed
                    msg = result.Status;
                    component.set('v.isHideDelete', true);
                    component.set('v.isHideAbort', false);
                    localStorage.removeItem('localStorageId');
                }
                component.set('v.apexLogsMsg', msg);
                component.set('v.status', result.Status);
            }
        })
        $A.enqueueAction(action);
    },
    abortMsg: function (component, event, helper) {
        var action = component.get("c.abortJob");
        var jobId = component.get('v.jobId');
        action.setParams({
            "jobId": jobId
        });

        action.setCallback(this, function (resp) {
            var state = resp.getState();
            if (state === "SUCCESS") {
                // var result = resp.getReturnValue();
                var msg = 'The Status is Aborted';
                component.set('v.apexLogsMsg', msg);
                component.set('v.progress', 100);
            }
        })
        $A.enqueueAction(action);
    }
})