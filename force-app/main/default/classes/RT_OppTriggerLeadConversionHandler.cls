public class RT_OppTriggerLeadConversionHandler extends TriggerHandler {
	public override void afterInsert(){
		LeadMergeWithOpportunity();
	}
		
	private void LeadMergeWithOpportunity(){
		List<Opportunity> lstOpportunityRecord= new List<Opportunity>();
		Set<Id> setOpportuntyIds = new Set<Id>();
		Set<String> setOpportunityNames = new Set<String>();
		Set<String> setOpportunityEmails = new Set<String>();
		Set<String> setOpportunityPhones = new Set<String>();
		Set<Id> setOpportunityAccountIds = new Set<Id>();


		for(Opportunity oppObj :(List<Opportunity>)Trigger.newMap.values()){
			lstOpportunityRecord.add(oppObj);
			setOpportuntyIds.add(oppObj.Id);
			setOpportunityNames.add(oppObj.Name);
			setOpportunityEmails.add(oppObj.Email__c);
			setOpportunityPhones.add(oppObj.Phone__c);
			setOpportunityAccountIds.add(oppObj.AccountId);
		}

		List<Lead> lstLeadRecords = new List<Lead>();
		for(Lead leadObj : [SELECT Id, Name, Company, Email, Phone 
							FROM Lead 
							WHERE Name IN : setOpportunityNames AND 
							(Phone IN : setOpportunityPhones OR Email IN : setOpportunityEmails)]){
			lstLeadRecords.add(leadObj);
		}
		Map<Id, Lead> mapLeadForConversion = new Map<Id, Lead>();
		for(Opportunity opp : lstOpportunityRecord){
			for(Lead leadobj: lstLeadRecords){ 
				if((opp.Name == leadobj.Name) && ((opp.Phone__c  == leadobj.Phone) || (opp.Email__c == leadobj.Email))){
						mapLeadForConversion.put(opp.Id, leadobj);
				}
			}
		}
		Map<Id,Account> mapAccountIds = new Map<Id,Account>([SELECT Id
																From Account 
																WHERE Id IN : setOpportunityAccountIds]);
		if(mapLeadForConversion.isEmpty()){
			List<Lead> objLeadRecord = new List<Lead>();
			for(Opportunity objOpp : lstOpportunityRecord){
				Lead newLead = new Lead();
				newLead.LastName = objOpp.Name;
				newLead.Company =objOpp.Account.Name;
				objLeadRecord.add(newLead);
			}
			INSERT objLeadRecord;
			//List<Account> objAccountRecord = new List<Account>();
			//List<Contact> objContactRecord = new List<Contact>();
			//for(Opportunity objOpp : lstOpportunityRecord){
			//	if(mapAccountIds.containsKey(objOpp.AccountId)){			
			//		Contact newContact = new Contact();
			//		newContact.AccountId = objOpp.AccountId;
			//		newContact.lastName = objOpp.Name;
			//		objContactRecord.add(newContact);
			//	}
			//	else{
			//		System.debug('Entering Null Part');
			//		Account newAccount = new Account();
			//		newAccount.Name = 'oooooo';
			//		INSERT newAccount;
			//		system.debug('oppppppp++==>'+newAccount);
			//		objAccountRecord.add(newAccount);
			//		Contact newContact = new Contact();
			//		system.debug('oppppppp++==>'+newAccount.Id);
			//		newContact.AccountId = newAccount.Id;
			//		newContact.lastName = objOpp.Name;
			//		objContactRecord.add(newContact);
			//	}
			//}
			//UPSERT objAccountRecord;
			//INSERT objContactRecord;
		}
		else{

			convertLead(setOpportunityAccountIds,lstOpportunityRecord,mapAccountIds,mapLeadForConversion);
			
		}
	}
	private void convertLead(Set<Id> setOpportunityAccountIds, List<Opportunity> lstOpportunityRecord, Map<Id,Account> mapAccountIds, Map<Id, Lead> mapLeadForConversion){
			LeadStatus convertStatus = [SELECT Id, MasterLabel FROM LeadStatus WHERE IsConverted=true LIMIT 1];
			list<Database.LeadConvert> leadConvertion = new list<Database.LeadConvert>();
			Contact leadContact = [SELECT Id FROM Contact 
                					WHERE AccountId In : setOpportunityAccountIds
                					ORDER BY CreatedDate desc LIMIT 1];
			for(Opportunity oppObject: lstOpportunityRecord){
				if(mapAccountIds.containsKey(oppObject.AccountId)){
					for(Id opportunityId : mapLeadForConversion.keySet()){
                		Database.LeadConvert leadCon = new Database.LeadConvert();
                		leadCon.setLeadId(mapLeadForConversion.get(opportunityId).Id);
                		leadCon.setAccountId(oppObject.AccountId);
                		leadCon.setContactId(leadContact.Id);
						leadCon.setOpportunityId(oppObject.Id);
                		leadCon.setConvertedStatus(convertStatus.MasterLabel);
                		leadConvertion.add(leadCon);
                	}
                }
                else{
					for(Id opportunityId : mapLeadForConversion.keySet()){
	                	Database.LeadConvert leadCon = new Database.LeadConvert();
                		leadCon.setLeadId(mapLeadForConversion.get(opportunityId).Id);
	                	leadCon.setConvertedStatus(convertStatus.MasterLabel);
                		leadConvertion.add(leadCon);

                	}
            	}
	        }
	        Database.LeadConvertResult[] lcr = Database.convertLead(leadConvertion);
	}
}