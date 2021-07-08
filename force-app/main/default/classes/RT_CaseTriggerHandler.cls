public class RT_CaseTriggerHandler extends TriggerHandler  {
    public override void beforeInsert(){
        OLA_Details((List<Case>) trigger.new);
        Set_Case_Fields_from_Zendesk_Fields((List<Case>) trigger.new);
    }
    public override void beforeUpdate(){
        OLA_Details((List<Case>) trigger.New);
        Set_Case_Fields_from_Zendesk_Fields((List<Case>) trigger.new);
        
    }
    private void  OLA_Details(List<Case> newCaseList){
        
        List<String> caseRecordTypeNameList = new List<String>{ 'PGi-Client External Support', 'PGi-Non PGi Product Support', 'PGi-Parent Ticket'};
            Map<Id,RecordType> recordTypeIdsMap = new Map<Id, RecordType>([SELECT Id,Name 
                                                                           FROM RecordType 
                                                                           WHERE Name IN :caseRecordTypeNameList]);
        
        
        
        
        Profile p = [Select Name from Profile where Id =: userinfo.getProfileid()];
        for(Case caseRecord : newCaseList){
           

            if((recordTypeIdsMap.containsKey(caseRecord.RecordTypeId))&&(p.Name != 'System Administrator') && 
               (caseRecord.Resolved__c != null) &&((caseRecord.Status =='Resolved')||(caseRecord.Status =='Closed'))) { 
                   if(caseRecord.Service_Restored__c == false){
                       caseRecord.Resolved_Queue__c = caseRecord.Current_Owner_s_Name__c;
                       caseRecord.Resolved__c =Date.today();
                       caseRecord.Resolved_by__c = userinfo.getUserId();
                       caseRecord.Restored_Queue__c = caseRecord.Current_Owner_s_Name__c;
                       caseRecord.Restored__c = Date.today();
                       caseRecord.Restored_by__c = userinfo.getUserId();
                       caseRecord.Service_Restored__c = true;
                   }
                   if(caseRecord.Service_Restored__c == true){
                       caseRecord.Resolved_Queue__c = caseRecord.Current_Owner_s_Name__c;
                       caseRecord.Resolved__c =Date.today();
                       caseRecord.Resolved_by__c = userinfo.getUserId();
                   }
                   if(caseRecord.Status == 'Closed'){
                       caseRecord.Closed_By__c = userinfo.getUserId();
                       caseRecord.Closed_Queue__c = caseRecord.Current_Owner_s_Name__c;
                   }
                   
                   
               }
            //left One Condition on prior value
            
            else if((caseRecord.Assigned_To__c != null) && (caseRecord.First_Assigned_Date_Time__c ==null)){
                caseRecord.First_Assigned_Date_Time__c = Date.today();
            }
            else if((recordTypeIdsMap.containsKey(caseRecord.RecordTypeId)) && (p.Name != 'System Administrator') &&
                    (caseRecord.Service_Restored__c == true) && (caseRecord.Restored__c == null)){
                caseRecord.Restored_Queue__c = caseRecord.Current_Owner_s_Name__c;
                caseRecord.Restored__c = Date.today();
                caseRecord.Restored_by__c = userinfo.getUserId();
            }
            
            else if((recordTypeIdsMap.get(caseRecord.RecordTypeId).Name =='PGi-Client External Support') && (p.Name != 'System Administrator')){
                 System.debug('>>Store>>->'+caseRecord.Service_Restored__c);
                 //System.debug('==Assign>>'+isChanged('Service_Restored__c',caseRecord));
                //Prior value condition to be added
                
                if((caseRecord.Status =='Closed')&& (caseRecord.IsClosed ==true)){
                    caseRecord.Closed_By__c = userinfo.getUserId();
                    caseRecord.Closed_Queue__c = caseRecord.Current_Owner_s_Name__c;
                }
                //Prior value condition to be added
                else if(caseRecord.Status =='Closed'){
                    caseRecord.Closed_By__c = null;
                    caseRecord.Closed_Queue__c =null;
                    caseRecord.Resolved_Queue__c = null;
                    caseRecord.Resolved__c = null;
                    caseRecord.Resolved_by__c = null;
                }// && isChanged('Service_Restored__c',caseRecord)
                else if(caseRecord.Service_Restored__c == true){
                    caseRecord.Restored_Queue__c = null;
                    caseRecord.Restored__c = null;
                    caseRecord.Restored_by__c = null;
                }               
                //Prior value condition to be added
                else if((caseRecord.Status =='Resolved')||(caseRecord.Status =='Closed')){
                    caseRecord.Resolved_Queue__c = null;
                    caseRecord.Resolved__c = null;
                    caseRecord.Resolved_by__c = null;
                }
            }
            
        }
    }
    private void Set_Case_Fields_from_Zendesk_Fields(List<Case> newCaseList){
        Map<Id,RecordType> recordTypeIdsMap = new Map<Id, RecordType>([SELECT Id,Name 
                                                                       FROM RecordType]);
        List<String> casePriofileNamesList = new List<String>{'PGi Service and Care Support','PGi Finance Support','PGi Technical Support','System Administrator','System Admin API Only','PGi Service Experience Managers','PGi Global Service Desk'};
            Map<Id,Profile> profileIdsMap = new Map<Id,Profile>([SELECT Id,Name 
                                                                 FROM Profile 
                                                                 WHERE Name IN : casePriofileNamesList]);
        
        for(Case caseRecord : newCaseList){
            if((profileIdsMap.containsKey(userinfo.getProfileId()) /*== 'System Admin API Only'*/) && (caseRecord.Status == 'New')&&
               (recordTypeIdsMap.get(caseRecord.RecordTypeId).Name == 'PGi-Client External Support') &&
               (caseRecord.ZD_Source__c != null)){
                   if(caseRecord.ZD_Source__c == 'Mail'){
                       caseRecord.Origin ='Email';
                   }
                   else if(caseRecord.ZD_Source__c == 'Web Form'){
                       caseRecord.Origin ='Web Ticket';
                   }
                   else if(caseRecord.ZD_Source__c == 'Chat'){
                       caseRecord.Origin ='Chat';
                   }
                   else if(caseRecord.ZD_Source__c == 'Closed Ticket'){
                       caseRecord.Origin ='Email';
                   }
                   else if(caseRecord.ZD_Source__c == 'Web Service'){
                       caseRecord.Origin ='Email';
                   }
               }
            else if((!profileIdsMap.containsKey(userinfo.getProfileId())) &&(caseRecord.Status == 'New')&&
                    (recordTypeIdsMap.get(caseRecord.RecordTypeId).Name == 'PGi-Client External Support') &&
                    (caseRecord.ZD_Source__c != null)){
                        
                        if(caseRecord.ZD_Source__c == 'Mail'){
                            caseRecord.Origin ='Email';
                        }
                        else if(caseRecord.ZD_Source__c == 'Web Form'){
                            caseRecord.Origin ='Web Ticket';
                        }
                        else if(caseRecord.ZD_Source__c == 'Chat'){
                            caseRecord.Origin ='Chat';
                        }
                        else if(caseRecord.ZD_Source__c == 'Closed Ticket'){
                            caseRecord.Origin ='Email';
                        }
                        else if(caseRecord.ZD_Source__c == 'Web Service'){
                            caseRecord.Origin ='Email';
                        }
                    }
            else if(recordTypeIdsMap.get(caseRecord.RecordTypeId).Name == 'PGi-Client External Support'){
                
                if(caseRecord.ZD_Status__c == 'Open'){
                    caseRecord.Status = 'In Progress';
                }
                else If(caseRecord.ZD_Status__c == 'Pending'){
                    caseRecord.Status = 'Pending Client Info/Action';
                }
                else If(caseRecord.ZD_Status__c == 'Solved'){
                    caseRecord.Status = 'Closed';
                }
            }
        }
    }
    
}