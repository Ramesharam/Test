@isTest
public class TBN_RT_BatchClassonLeads {
    @isTest Static void TBN_RT_BatchClassonLeads(){
        Lead TestLead = new Lead(Status = 'Working',
                                 lastname = 'DFEG',
                                 company = 'POP');
        INSERT TestLead;
        for(Task obj:[SELECT Subject, whoid FROM Task WHERE whoid=: TestLead.id]){
            System.assertEquals('Working', obj.Subject);
        }
        test.startTest();
        RT_BatchClassonLead obj = new RT_BatchClassonLead ();
        Database.executeBatch(obj, 10);
        test.stopTest();
    }
}