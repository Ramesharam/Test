/**
 * Ticket No   : 292 
 * ClassName   : PurgeApexLogsBatch
 * @author     : Anup
 * Description : in this batch apex class we are delete the apexlogs 
 */

global class PurgeApexLogsBatch implements Database.Batchable<sObject>,Database.AllowsCallouts {
    global Database.querylocator start(Database.BatchableContext BC){
        return Database.getQueryLocator('SELECT Id FROM ApexLog');
    }
    global void execute(Database.BatchableContext BC, List<SObject> scope){
       
        for(SObject al: scope){
            Http h = new Http();
            HttpRequest req = new HttpRequest();
            req.setEndpoint(Url.getOrgDomainUrl().toExternalForm()
                            + '/services/data/v44.0/sobjects/Apexlog/'+al.Id);
            req.setMethod('DELETE');
            req.setHeader('Authorization', 'Bearer ' + UserInfo.getSessionId());
            HttpResponse res = h.send(req);
        }	
    }
    global void finish(Database.BatchableContext bc){
        
    }
}