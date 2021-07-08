/*
@ClassName   : RT_FinanceRequestTriggerHandler
@JIRATicket  : None
@CreatedOn   : 30/Apr/2019
@ModifiedBy  : Ramesh
@Description : Class is used handle Trigger methods
*/
public class RT_FinanceRequestTriggerHandler {
    //public static Boolean isFirstTime = true;
    /*
    * Method Name :beforeUpdate
    * Params: newRecord
    * Description: Updating the values in the finance request object
    */
    public void beforeUpdate(list<Finance_Req__c> newRecord){
        Populate(newRecord);
    }
    /*
    * Method Name :beforeInsert
    * Params: newRecord
    * Description: Inserting the values in the finance request object
    */
    public void beforeInsert(list<Finance_Req__c> newRecord){
        Populate(newRecord);
    }
    /*
    * Method Name :afterInsert
    * Params: newRecord
    * Description: Inserting Attachments to finance request object
    */
    public void afterInsert(list<Finance_Req__c> newRecord){
        insertAttachment(newRecord);
    }
    /*
    * Method Name :afterUpdate
    * Params: newRecord
    * Description: Inserting and Deleting Attachments in finance request object
    */
    public void afterUpdate(list<Finance_Req__c> newRecord){
        list<id> lstFinanceids = new list<id>();
        Set<id> lstCaseId = new Set<id>();
        for(Finance_Req__c ob: newRecord){

            if((ob.Historical_caseId__c != null || ob.Historical_caseId__c != null ) &&(ob.Historical_caseId__c.startsWith('500'))){
                lstCaseId.add(ob.Historical_caseId__c);
            }

            lstFinanceids.add(ob.id);
        }
                               
        if(lstCaseId.isEmpty()){
             List<Attachment> lstAttachmentDelete= [SELECT id, ParentId
                                                FROM Attachment 
                                                WHERE ParentId IN :lstFinanceids];
            DELETE lstAttachmentDelete;
        }
        else{
                       insertAttachment(newRecord);
        }
    }
    /*
    * Method Name :Populate
    * Params: newRecord
    * Description: Populating Comments on finance Request custom object
    */
    private void Populate(list<Finance_Req__c> newRecord){
        List<Finance_Req__c> obj = new List<Finance_Req__c>();
        Set<String> caseid = new Set<String>();
        for(Finance_Req__c ob: newRecord){
            if(ob.Historical_caseId__c==null || ob.Historical_caseId__c.startsWith('500') ){
                caseid.add(ob.Historical_caseId__c); 
            }
        }
        map<ID, List<CaseComment>> mapOfComments = new  map<ID,List<CaseComment>>();
        for(CaseComment caseToPopulate: [SELECT ParentId, CommentBody, CreatedDate
                                        FROM CaseComment 
                                        WHERE ParentId IN : caseid]){
                                            if(!mapOfComments.containskey(caseToPopulate.ParentId)){
                                                mapOfComments.put(caseToPopulate.ParentId, new list<CaseComment>{caseToPopulate});
                                            }
                                            else{
                                                mapOfComments.get(caseToPopulate.ParentId).add(caseToPopulate);
                                            }
        }
        for(Finance_Req__c populateId: newRecord){

            if(populateId.Historical_caseId__c==null || populateId.Historical_caseId__c.startsWith('500') ){
                if(mapOfComments.containskey(populateId.Historical_caseId__c)){
                    List<CaseComment> CommentRecord = mapOfComments.get(populateId.Historical_caseId__c);
                    String strComment ='';
                    for(CaseComment custom : CommentRecord){
           
                    strComment = custom.CommentBody+'\n'+strComment; 
                                                 
                    }
                    String strcaseid = populateId.Historical_caseId__c;
                    if(populateId.Internal_comments__c!=null && populateId.Internal_comments__c.indexOf(strcaseid) == -1){
                        populateId.Internal_comments__c =strComment+populateId.Internal_comments__c;
                    }
                    else{
                       populateId.Internal_comments__c =strComment;
                    }
                }
                else{
                    populateId.Internal_comments__c ='';
                }    
            }else{
                populateId.addError('Enter Proper caseid.');
            }
            
        }
    }
    /*
    * Method Name :insertAttachment
    * Params: newRecord
    * Description: adding Attachments to finance request object
    */
    Private void insertAttachment(list<Finance_Req__c> newRecord){
        Set<Id> setCaseIds = new Set <Id>();
        for(Finance_Req__c ob : newRecord){
            if(ob.Historical_caseId__c==null || ob.Historical_caseId__c.startsWith('500')){
                setCaseIds.add(ob.Historical_CaseId__c);
            }
        }
        map<id,List<Attachment>> mapForAttach = new map<id,List<Attachment>>();
        for( Attachment attach : [SELECT ParentId, id, name ,body
                                    FROM Attachment 
                                    WHERE ParentId IN :setCaseIds]){
            if(mapForAttach.containsKey(attach.ParentId)){
                    mapForAttach.get(attach.ParentId).add(attach);
            }
            else{
                    mapForAttach.put(attach.ParentId,new List<Attachment>{attach} );
            }
        }

        System.debug('ooooooooooooooooooooooo>>'+mapForAttach); 
        List<Attachment>lstAttachtoInsert = new List<Attachment>();
        for(Finance_Req__c financeObject : newRecord){
            List<Attachment> lstAttachment = mapForAttach.get(financeObject.Historical_CaseId__c);
            System.debug('<<<Attactlist>>'+lstAttachment);
            if(financeObject.Historical_caseId__c != null && mapForAttach.containskey(financeObject.Historical_caseId__c)){
                for(Attachment att : lstAttachment){
                    Attachment at = new Attachment();
                    at.name = att.name;
                    at.body = att.body;
                    at.parentid = financeObject.Id;
                    lstAttachtoInsert.add(at);
                }    
            }
            if(!lstAttachtoInsert.isEmpty())
                    INSERT lstAttachtoInsert;
        }
        System.debug(''+lstAttachtoInsert);


       /* list<Id> lstFinanceRecordids = new list<Id>();
        Set<Id> setCaseId = new Set<Id>();
        for(Finance_Req__c ob: newRecord){
            lstFinanceRecordids.add(ob.id); 
            setCaseId.add(ob.Historical_caseId__c);
        }
        list<Attachment> lstAttach =[SELECT id, name, body 
                                    FROM Attachment 
                                    WHERE ParentId = :setCaseId];
         list<Attachment> insertAttList = new list<Attachment>();
         for(id caseid:lstFinanceRecordids){
            for(Attachment a: lstAttach)
            {
               Attachment att = new Attachment(name = a.name, body = a.body, parentid = caseid);
               system.debug('ooooooooo>>'+att);
               insertAttList.add(att);
            }
         INSERT insertAttList;
     }*/


    }
}