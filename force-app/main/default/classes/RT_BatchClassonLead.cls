global class RT_BatchClassonLead implements Database.Batchable<sObject>
 {  
/*  Method Name : Start
    @param      : BatchableContext vafriable
    Description : This method will Start The Batch Process
*/
    global Database.QueryLocator start(Database.BatchableContext BC)
    {
                return Database.getQueryLocator('SELECT Id, Status, Industry, Company, LeadSource FROM Lead');
    }
/*  Method Name : Execute
    @param      : BatchableContext vafriable , LeadRecords
    Description : This method will Execute The Batch Process
*/
    global void execute(Database.BatchableContext BC, List<Lead> LeadRecords)
    {
		List<Task> LeadList = new List<Task>();
	
            for(Lead LstLead : LeadRecords)
            {
               Task taskObj = createTask(LstLead.Id,LstLead.Status);
				LeadList.add(taskObj);  
            }		
			INSERT LeadList;	
    }
/*  Method Name :createTask
    @param      : Id, Subject
    Description :For Creating Task for Lead This method is written
    */
    global Task createTask(String Id,String Subject){
        Task LeadStatusTask = new Task();
        LeadStatusTask.Subject = Subject;
        LeadStatusTask.Type = 'Outbound Call';
        LeadStatusTask.Status = 'Open';
        LeadStatusTask.Priority = 'Normal';
        LeadStatusTask.ActivityDate= date.today()+2;
        LeadStatusTask.whoid = Id;
        return LeadStatusTask;     
       } 
/*  Method Name : finish
    @param      : BatchableContext vafriable
    Description : 
*/   
    global void finish(Database.BatchableContext BC)
    {
        
    }
}