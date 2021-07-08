({
    onPageReferenceChange: function(cmp, evt, helper) {
        var myPageRef = cmp.get("v.pageReference");
        console.log('pageReference=>',JSON.parse(JSON.stringify(myPageRef)));
        var firstname = myPageRef.state.c__lastname;
        cmp.set("v.firstname", firstname);
    }
})