Global class LeadProcessor implements Database.Batchable<sObject>, Database.stateful{
      integer count=0;
	global Database.QueryLocator start(Database.BatchableContext bc) {
        return Database.getQueryLocator('SELECT Id, Company, Industry, LeadSource, Phone FROM Lead');
    }
    global void execute(Database.BatchableContext bc, List<Lead> scope){
        List<Lead> LeadList = new List<Lead>();
      
        for(Lead lst :scope){
            lst.LeadSource = 'Dreamforce';
            count=+1;
            LeadList.add(lst);
        }
        UPDATE LeadList;
    }
    global void finish(Database.BatchableContext bc){
        System.debug('---->'+count);
    }
}