/** Class Name	:TBN_RT_TriggeronContact_Test
*/
@isTest
private class TBN_RT_TriggeronContact_Test {
/** Method Name	:testForInsertionFirstRecord
*  @param		:
*  Description	:Method used to check if the first record is inserting properly or not    
*/
    @isTest static void testForInsertionFirstRecord(){
        Account acct = new Account(Name = 'Exam');
        INSERT acct;
        Contact insertingContact = new Contact(firstName = 'raghu',
                                               LastName = 'Ram',
                                               accountid = acct.id );
        INSERT insertingContact;
        for(Account actobj : [SELECT id,ContactsCount__c,Contact_Name__c 
                              FROM Account WHERE id =: acct.id]){
                                  System.assertEquals(1, actobj.ContactsCount__c);
                                  System.assertEquals('raghuRam;', actobj.Contact_Name__c);
                              }
    }
/** Method Name	:testForDeletionLastRecord
*  @param		:
*  Description	:Method used to check if the last record is deleteing properly or not    
*/
    @isTest static void testForDeletionLastRecord(){
        Decimal contactsCount = 0;
        String contactNames = 'Null';
        Account acct = new Account(Name = 'Exam');
        INSERT acct;
        Contact insertedForDeletion = new Contact(firstName = 'raghu',
                                                  LastName = 'Ram',
                                                  accountid = acct.id );
        INSERT insertedForDeletion;
        DELETE insertedForDeletion;	
        for(Account actobj : [SELECT id,ContactsCount__c,Contact_Name__c 
                              FROM Account WHERE id =: acct.id]){
                                  System.assertEquals(0, actobj.ContactsCount__c);
                                  System.assertEquals(null, actobj.Contact_Name__c);
                              }
    }
/** Method Name	:testforMultipleDeletionInsertion
*  @param		:
*  Description	:Method used to check the multiple records inserting and deleting properly or not    
*/
    @isTest static void testforMultipleDeletionInsertion(){
        Account acct = new Account(Name = 'Exam');
        INSERT acct;
        Contact contactForDelete = new Contact(firstName = 'raghu',
                                               LastName = 'Ram',
                                               accountid = acct.id );
        INSERT contactForDelete;
        Contact contactInsertion = new Contact(firstName = 'abc',
                                               LastName = 'abc',
                                               accountid = acct.id );
        INSERT contactInsertion;
        
        
        for(Account actObjectForTest : [SELECT ContactsCount__c, Contact_Name__c 
                                        FROM Account WHERE id =: acct.Id]){
                                            System.assertEquals(2, actObjectForTest.ContactsCount__c);
                                            System.assertEquals('raghuRam, abcabc;', actObjectForTest.Contact_Name__c);
                                        }        
        DELETE contactForDelete;
        
        for(Account actObjectForTest : [SELECT ContactsCount__c, Contact_Name__c 
                                        FROM Account WHERE id =: acct.Id]){
                                            System.assertEquals(1, actObjectForTest.ContactsCount__c);
                                            System.assertEquals('abcabc;', actObjectForTest.Contact_Name__c);
                                        }
    }
/** Method Name	:testForUpdation
*  @param		:
*  Description	:Method used to check updation is taking place or not    
*/
    @isTest static void testForUpdation(){
        Account acct1 = new Account(name='Exam');
        INSERT acct1;
        Contact contact1 = new Contact(firstName = 'abcd',
                                       LastName = 'XYZ',
                                       accountid = acct1.id);
        INSERT contact1;
        for(Account getCountNameFromACT1 : [Select ContactsCount__c, Contact_Name__c 
                                            FROM Account WHERE id =: acct1.id]){
                                                System.assertEquals(1, getCountNameFromACT1.ContactsCount__c);
                                                System.assertEquals('abcdXYZ;',getCountNameFromACT1.Contact_Name__c);
                                            }
        Account acct2 = new Account(name = 'Grade');
        INSERT acct2;
        Contact contact2 = new Contact(firstName = 'bob',
                                       LastName = 'alice',
                                       accountid = acct2.id);
        INSERT contact2;
        for(Account getCountNameFromACT2 : [Select ContactsCount__c, Contact_Name__c 
                                            FROM Account WHERE id =: acct2.id]){
                                                System.assertEquals(1, getCountNameFromACT2.ContactsCount__c);
                                                System.assertEquals('bobalice;',getCountNameFromACT2.Contact_Name__c);
                                            }
        contact1.accountid = acct2.id;
        UPDATE contact1;
        for(Account getCountNameFromACT1 : [Select ContactsCount__c, Contact_Name__c 
                                            FROM Account WHERE id =: acct1.id]){
                                                System.assertEquals(0, getCountNameFromACT1.ContactsCount__c);
                                                System.assertEquals(null,getCountNameFromACT1.Contact_Name__c);
                                            }
        for(Account getCountNameFromACT2 : [Select ContactsCount__c, Contact_Name__c 
                                            FROM Account WHERE id =: acct2.id]){
                                                System.assertEquals(2, getCountNameFromACT2.ContactsCount__c);
                                                System.assertEquals('abcdXYZ, bobalice;',getCountNameFromACT2.Contact_Name__c);
                                            }
    }
}