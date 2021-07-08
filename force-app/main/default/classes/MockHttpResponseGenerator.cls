@isTest
global class MockHttpResponseGenerator implements HttpCalloutMock {
    // Implement this interface method
    global HTTPResponse respond(HTTPRequest req) {
        // Optionally, only send a mock response for a specific endpoint
        // and method.
        System.assertEquals(URL.getSalesforceBaseUrl().toExternalForm() + '/services/data/v41.0/tooling/query/?q=SELECT+Type,+Label,+Remaining,+Max,+EntityDefinitionid+FROM+EntityLimit+where+EntityDefinitionid+=\'Account\'', req.getEndpoint());
        System.assertEquals('GET', req.getMethod());
        
        // Create a fake response
        HttpResponse res = new HttpResponse();
        res.setHeader('Content-Type', 'application/json');
        res.setBody('{"size":11,"totalSize":11,"done":true,"queryLocator":null,"entityTypeName":"EntityLimit","records":[{"attributes":{"type":"EntityLimit","url":"/services/data/v41.0/tooling/sobjects/EntityLimit/Account.CustomFields"},"Type":"CustomFields","Label":"Custom Fields","Remaining":493,"Max":500,"EntityDefinitionId":"Account"}]}');
        res.setStatusCode(200);
        return res;
    }
}