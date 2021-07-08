@IsTest
private class EntityLimitsResponseControllerTest {
    
    static testMethod  void testAll() {
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator());
        HttpRequest req = new HttpRequest();
        req.setHeader('Authorization', 'Bearer ' + UserInfo.getSessionID());
        req.setEndpoint(URL.getSalesforceBaseUrl().toExternalForm() + '/services/data/v41.0/tooling/query/?q=SELECT+Type,+Label,+Remaining,+Max,+EntityDefinitionid+FROM+EntityLimit+where+EntityDefinitionid+=\'Account\'' );
        req.setMethod('GET');
        Http h = new Http();
        HttpResponse res = h.send(req);
        
        Map<String, Object> responseMap = (Map<String, Object>) JSON.deserializeUntyped(res.getBody()); 
        
        List<Object> dataMap = (List<Object>) responseMap.get('records');
        Map<String, Object> newCast = (Map<String, Object>)dataMap[0];
        
        Decimal usage = (((Integer.valueOf(newCast.get('Max'))-Integer.valueOf(newCast.get('Remaining')))*100)/Integer.valueOf(newCast.get('Max')));
        EntityLimitsResponseController.getallobjects();
        
        Object_Limit__c ObjLim = [select Object_Type__c,Remaining__c,Label__c,Max__c,Usage__c from Object_Limit__c Where Object_Type__c='Account'  limit 1]; 
        System.assertEquals(ObjLim.Usage__c, usage);
    }
    
    
}