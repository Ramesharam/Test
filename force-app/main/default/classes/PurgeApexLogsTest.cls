@isTest
public class PurgeApexLogsTest {
    public static testMethod void callTest(){
        StaticResourceCalloutMock mock = new StaticResourceCalloutMock();
        mock.setStaticResource('PurgeApexLogs');
        mock.setStatusCode(200);
        mock.setHeader('Content-Type', 'application/json;charset=UTF-8');
        Test.setMock(HttpCalloutMock.class, mock);
        
        test.startTest();
        PurgeApexLogs obj = new PurgeApexLogs();
        PurgeApexLogs.callBatchApex();
        Test.stopTest();
    }
    
    public static testMethod void displayTest(){
        
        StaticResourceCalloutMock mock = new StaticResourceCalloutMock();
        mock.setStaticResource('PurgeApexLogs');
        mock.setStatusCode(200);
        mock.setHeader('Content-Type', 'application/json;charset=UTF-8');
        Test.setMock(HttpCalloutMock.class, mock);
        PurgeApexLogsBatch obj = new PurgeApexLogsBatch();
        Id jobId = Database.executeBatch(obj);
        Test.startTest();
        PurgeApexLogs.displayMessage(jobId);
        AsyncApexJob deleteJob = [SELECT Status, TotalJobItems, JobType, ApexClassId, NumberOfErrors 
                                  FROM AsyncApexJob 
                                  WHERE Id =: jobId 
                                  limit 1 ];
        Test.stopTest();
    }
    
    public static testMethod void abortTest(){
        StaticResourceCalloutMock mock = new StaticResourceCalloutMock();
        mock.setStaticResource('PurgeApexLogs');
        mock.setStatusCode(200);
        mock.setHeader('Content-Type', 'application/json;charset=UTF-8');
        Test.setMock(HttpCalloutMock.class, mock);
        PurgeApexLogsBatch obj = new PurgeApexLogsBatch();
        Id jobId = Database.executeBatch(obj);
        Test.startTest();
        PurgeApexLogs.abortMessage(jobId);
        AsyncApexJob aJob = [SELECT Id ,Status, ApexClass.Name 
                             FROM AsyncApexJob 
                             WHERE Id =:jobId  Limit 1];
        Test.stopTest();
    }
}