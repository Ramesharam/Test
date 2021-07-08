/**
* Ticket No   : RT-292
* ClassName   : PurgeApexLogs
* @author     : Anup
* Description : In this class we delete the apexlogs and display the status of the job
*/
public class PurgeApexLogsController {
/**
*  MethodName : callBatchApex
*  @param     : 
*  Description: it will call the batch and it return the id of the job
*/
    @AuraEnabled
    public static Id callBatchApex(){
        PurgeApexLogsBatch obj = new PurgeApexLogsBatch();
        // We have to delete only 100 records on each execution
        Id jobId = Database.executeBatch(obj,100);
        return jobId;
    }
/**
* MethodName : deleteJob
* @param     : jobId
* Description: based on the jobid we are displaying the status of the job 
*/
    @AuraEnabled
    public static AsyncApexJob deleteJob(String jobId){
        AsyncApexJob deletedJob = [SELECT Status, TotalJobItems, JobType, ApexClassId, NumberOfErrors 
                                   FROM AsyncApexJob 
                                   WHERE Id =: jobId 
                                   limit 1
                                  ];
        return deletedJob;
        
    }
/**
* MethodName : abortJob
* @param     : jobId
* Description: In this method we are abort the job based on Status 
*/
    @AuraEnabled
    public static AsyncApexJob abortJob(String jobId){
      // AsyncApexJob asyJob;
        System.AbortJob(jobId);
       AsyncApexJob asyJob = [SELECT Id ,Status, ApexClass.Name 
                			  FROM AsyncApexJob 
                     		  WHERE Id =:jobId  Limit 1
                             ];
        return asyJob; 
    }
}