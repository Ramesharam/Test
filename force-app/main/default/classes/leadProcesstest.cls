@isTest
public class leadProcesstest {
    Public void testit(){
        List<Lead> l_lst = new List<Lead>();
        for(Integer i=0; i<200; i++){
            Lead l = new Lead();
            l.LastName = 'name'+i;
            l.company = 'Company';
            l.status = 'random';
            l_lst.add(l);
        }
        insert l_lst;
        Test.startTest();
        LeadProcessor lp = new LeadProcessor();
        Id batchId = Database.executeBatch(lp,200);
		Test.stopTest();
    }
}