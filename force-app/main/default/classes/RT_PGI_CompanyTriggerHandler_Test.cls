@isTest
public class RT_PGI_CompanyTriggerHandler_Test {
	@TestSetup static void populateRelatedAccount(){
		Account act1 = new Account(Name = 'abcd');
		Account act2 = new Account(Name = 'pppp',
								   SFDC_Account_ID__c ='12345');
		INSERT act1;
		INSERT act2;
		Opportunity oppObj1 = new Opportunity(Name='uuu', CloseDate =Date.today(), StageName = 'new');
		INSERT oppObj1;
		PGI_Contract__c pgiContractObj1 = new PGI_Contract__c(Name ='pop', Opportunity__c = oppObj1.Id);
		INSERT pgiContractObj1;
		PGI_Company__c pgiObject1 =new PGI_Company__c(Name= 'abcd', CorpCust_SF_Account_ID__c =act1.Id, Direct_SF_Oppty_ID__c =pgiContractObj1.Opportunity__c);
		PGI_Company__c pgiObject2 =new PGI_Company__c(Name = 'ttttt', SF_Account_ID__c ='12345', SF_Opportunity_ID__c =pgiContractObj1.Opportunity__c);
		INSERT pgiObject1;
		INSERT pgiObject2;
        Opportunity oppObj2 = new Opportunity(Name='vvv', CloseDate =Date.today(), StageName = 'new');
		INSERT oppObj2;
		PGI_Contract__c pgiContractObj2 = new PGI_Contract__c(Name ='bob', Opportunity__c = oppObj2.Id);
		INSERT pgiContractObj2;
        PGI_Contract__c pgiContractObj3 = new PGI_Contract__c(Name ='jack', Opportunity__c = oppObj2.Id);
		INSERT pgiContractObj3;
        
	}
	 @isTest static void PopulatedFromAccount(){
	 	Account a = [SELECT Id, Name FROM Account WHERE Name='abcd'];
        PGI_Company__c pgiObj = [SELECT Id, Related_Account__c FROM PGI_Company__c WHERE Name = 'abcd'];
        System.assertEquals(pgiObj.Related_Account__c, a.Id);
    }
    @isTest static void updatedInContract(){
    	PGI_Company__c pgiObj = [SELECT Id,Name FROM PGI_Company__c WHERE Name = 'ttttt'];
	 	PGI_Contract__c pgiContractObj = [SELECT Id, PGi_Company__c FROM PGI_Contract__c WHERE Name='pop'];

        System.assertEquals(pgiObj.Id, pgiContractObj.PGI_Company__c);
     }

}