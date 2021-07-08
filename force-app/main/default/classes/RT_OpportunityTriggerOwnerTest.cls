/*
@ClassName : RT_OpportunityTriggerOwnerTest
@CreatedOn : TODAY's DATE
@ModifiedBy : DEEVLOPER NAME
@Description : Test class for Owner Assignment trigger
*/
@isTest
public class RT_OpportunityTriggerOwnerTest {
    /*
    * Method Name :ownerAssignmentTest
    * Params: 
    * Description: Inserting Values to test
    */
    @TestSetup private static void ownerAssignmentTest(){
        Profile p1 = [SELECT Id FROM Profile WHERE Name = 'System Administrator'];
        User u = new User(Alias = 'abcd', Email='standarduser@testorg.com', Default_Owner__c=true, 
                          EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US', 
                          LocaleSidKey='en_US', ProfileId = p1.Id,
                          TimeZoneSidKey='America/Los_Angeles', UserName='getsuitable@testorg.com');
        INSERT u;
        Opportunity opportunityObject = new Opportunity(Name = 'Plane',
                                                        StageName ='StageName',
                                                        CloseDate = System.today()+3,
                                                        External_ID_Populated__c = '111');
        INSERT opportunityObject;
    }
    /*
    * Method Name :testmethod1
    * Params: 
    * Description: Asserting the Output
    */
    private static testmethod void testmethod1(){
        User u = [SELECT Id FROM USER WHERE Default_Owner__c = true Limit 1 ];
        Opportunity oppAssignedRecord = [SELECT OwnerId FROM Opportunity WHERE Name = 'Plane'];
        System.assertEquals(u.Id,oppAssignedRecord.OwnerId);
        
    }
    /*
    * Method Name :testmethod2
    * Params: 
    * Description: Testing the Exception case
    */

    private static testmethod void testmethod2(){
        User u = [SELECT Id FROM USER Limit 1 ];
        User u1 = [SELECT Id FROM USER ORDER BY Name DESC Limit 1 ];
        System.debug('In'+u1);
        Opportunity opportunityObject = new Opportunity(Name = 'Plane11',
                                                        StageName ='StageName',
                                                        CloseDate = System.today()+3,
                                                        OwnerId = u1.Id,
                                                        External_ID_Populated__c = '111');
        //External_ID_Populated__c = '111');
        INSERT opportunityObject;
        System.debug('==>>'+opportunityObject);
        opportunityObject.OwnerId = u1.Id;
        try{
            UPDATE opportunityObject;
        }
        catch(Exception e){
            Boolean expectedExceptionThrown =  e.getMessage().contains('Not Possible to change') ? true : false;
            System.AssertEquals(expectedExceptionThrown, true);
            
        }        
    }  
}