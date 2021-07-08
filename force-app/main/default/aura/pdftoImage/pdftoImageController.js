({
    handleUploadFinished: function (cmp, event) {
        // Get the list of uploaded files
        var uploadedFile = event.getParam("files");
        alert("Files uploaded : " + uploadedFile.length);
        var documentId  = uploadedFile[0].documentId;
        console.log('Document ID:',documentId);
        cmp.set("v.docId",documentId);
    },
    downloadfile : function (component, event, helper){                 
        var id = event.target.getAttribute("data-id");       
        alert('Document ID:' +id);
        var actiondownload = component.get("c.DownloadAttachment");
        
        actiondownload.setParams({
            "DownloadAttachmentID": id
        });
        
        actiondownload.setCallback(this, function(b){
            component.set("v.Baseurl", b.getReturnValue());
            var urlEvent = $A.get("e.force:navigateToURL");
            urlEvent.setParams({
                "url": b.getReturnValue()
            });
            urlEvent.fire();
        });
    }
})