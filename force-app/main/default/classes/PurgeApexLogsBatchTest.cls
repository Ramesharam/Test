@isTest
public class PurgeApexLogsBatchTest {
    public static testMethod void test(){
        
        List<ApexLog> lst = [SELECT Id,Status FROM ApexLog limit 100];
      
        StaticResourceCalloutMock mock = new StaticResourceCalloutMock();
        mock.setStaticResource('PurgeApexLogs');
        mock.setStatusCode(200);
        mock.setHeader('Content-Type', 'application/json;charset=UTF-8');
        Test.setMock(HttpCalloutMock.class, mock);
   
        
        Test.startTest();
        PurgeApexLogsBatch obj = new PurgeApexLogsBatch();
        DataBase.executeBatch(obj);
        Test.stopTest();
    }
}