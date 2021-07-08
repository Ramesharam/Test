trigger RT_PGI_CompanyTrigger on PGi_Company__c (before insert, after insert) {
	new RT_PGI_CompanyTriggerHandler().run();
}