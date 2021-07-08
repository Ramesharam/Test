@isTest
public class RT_CaseTriggerHandler_Test {
    @TestSetup static void testCaseTrigger(){
        
        String uniqueUserName = 'standarduser' + DateTime.now().getTime() + '@testorg.com';
        // This code runs as the system user
        Profile p = [SELECT Id FROM Profile WHERE Name='Standard User'];
        User u = new User(Alias = 'standt', Email='standarduser@testorg.com',
                          EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US',
                          LocaleSidKey='en_US', ProfileId = p.Id,
                          TimeZoneSidKey='America/Los_Angeles',
                          UserName=uniqueUserName);
        
        System.runAs(u) {
            RecordType recordTypeId = [SELECT Id FROM RecordType WHERE Name='PGi-Client External Support'];
       
           List<Case> newCaseList = new List<Case>{new Case(Status ='Closed', Origin='Email',Resolved__c=Date.today(),
                                                             Service_Restored__c = false, RecordTypeId =recordTypeId.Id),
                new Case(Status ='New', Origin='Email',Assigned_To__c =Userinfo.getUserId(),
                         RecordTypeId =recordTypeId.Id),
                new Case(Status = 'New', Service_Restored__c = True, Origin='Email',
                         RecordTypeId =recordTypeId.Id),
                new Case(Status = 'Closed', Origin='Email',
                         RecordTypeId =recordTypeId.Id),
                new Case(Status = 'Resolved', Origin='Email',
                         RecordTypeId =recordTypeId.Id),
                new Case(Status = 'New', Origin='Email',Service_Restored__c = false,
                         RecordTypeId =recordTypeId.Id,Restored__c=Date.today()),
                new Case(Status = 'New', Origin='Email',
                         RecordTypeId =recordTypeId.Id, ZD_Source__c = 'Mail'),
                new Case(Status = 'New', Origin='Email',
                         RecordTypeId =recordTypeId.Id, ZD_Source__c = 'Web Form'),
                new Case(Status = 'New', Origin='Email',
                         RecordTypeId =recordTypeId.Id, ZD_Source__c = 'Chat'),
                new Case(Status = 'New', Origin='Email',
                         RecordTypeId =recordTypeId.Id, ZD_Source__c = 'Closed Ticket'),
                new Case(Status = 'New', Origin='Email',
                         RecordTypeId =recordTypeId.Id, ZD_Source__c = 'Web Service'),
                new Case(Status = 'New', Origin='Email',
                         RecordTypeId =recordTypeId.Id, ZD_Status__c = 'Open'),
                new Case(Status = 'New', Origin='Email',
                         RecordTypeId =recordTypeId.Id, ZD_Status__c = 'Pending'),
                new Case(Status = 'New', Origin='Email',
                         RecordTypeId =recordTypeId.Id, ZD_Status__c = 'Solved')};
                             INSERT newCaseList;
            
           	newCaseList[5].Service_Restored__c = true; 
            UPDATE newCaseList[5];
            System.debug('newCaseList>>>>>>>>> '+newCaseList[5].Service_Restored__c);
        }
      RecordType recordTypeId = [SELECT Id FROM RecordType WHERE Name='PGi-Client External Support'];
        List<Case> newCaseList = new List<Case>{new Case(Status = 'New', Origin='Email',
                                                         RecordTypeId =recordTypeId.Id, ZD_Source__c = 'Mail'),
            new Case(Status = 'New', Origin='Email',
                     RecordTypeId =recordTypeId.Id, ZD_Source__c = 'Web Form'),
            new Case(Status = 'New', Origin='Email',
                     RecordTypeId =recordTypeId.Id, ZD_Source__c = 'Chat'),
            new Case(Status = 'New', Origin='Email',
                     RecordTypeId =recordTypeId.Id, ZD_Source__c = 'Closed Ticket'),
            new Case(Status = 'New', Origin='Email',
                     RecordTypeId =recordTypeId.Id, ZD_Source__c = 'Web Service')};
       INSERT newCaseList;
    }
    @isTest static void testMethod1(){
        Case resultCase =[SELECT Resolved_by__c FROM Case WHERE Origin ='Email' LIMIT 1];
       // System.assertEquals(resultCase.Resolved_by__c, userinfo.getUserId());
    }
    
}