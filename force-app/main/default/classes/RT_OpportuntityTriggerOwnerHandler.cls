public class RT_OpportuntityTriggerOwnerHandler extends TriggerHandler {
	public override void beforeInsert(){
		handleOwnerAssignment((List<Opportunity>) trigger.new);
	}
	public override void afterUpdate(){
		handleUpdateValidation((Map<Id, Opportunity>) trigger.oldMap, (List<Opportunity>) trigger.new);
	}
	//public override void afterInsert(){
	//			SharingRecords((List<Opportunity>) trigger.new);
	//}
	/**
	* @Method Name : handleOwnerAssignment
	* @Param : trigger.old 
	* @ReturnType : void
	* @Discription : Assigning Default owner to the Opportunity
	*/
	private void handleOwnerAssignment(List<Opportunity> opportunityList){
		User userRecord = [SELECT Id FROM User WHERE Default_Owner__c =true Limit 1];

		for(Opportunity oppRecord : opportunityList){
			if(oppRecord.External_ID_Populated__c != null && oppRecord.OwnerId != userRecord.Id){
					oppRecord.OwnerId = userRecord.Id;
			}
		}	
	}
	private void handleUpdateValidation(Map<Id,Opportunity> oldMap, List<Opportunity> newOpportunityList){
				User defaultUserRecord = [SELECT Id FROM User WHERE Default_Owner__c =true Limit 1];
				Id uid = userinfo.getUserId();
				System.debug('Inside Error>>>'+uid);

				for(Opportunity oppRecordNew : newOpportunityList){
					Opportunity oldOpp = oldMap.get(oppRecordNew.ID);
					System.debug('::Old::>>'+oldOpp);
					System.debug(':::New:::>>'+oppRecordNew);
					
						System.debug('----->>'+oppRecordNew.OwnerId);
						System.debug('-++---->>'+uid);
						if (oppRecordNew.OwnerId != uid) {
							if (oldOpp.OwnerId != defaultUserRecord.Id && oldOpp.OwnerId != oppRecordNew.OwnerId) {
								System.debug('Inside Error');
								oppRecordNew.Adderror('Not Possible to change');
							}
						}
					
				}

	}
	/*private void SharingRecords(List<Opportunity> opportunityList){
				User userRecord = [SELECT Id FROM User WHERE Default_Owner__c =true Limit 1];
				List<Opportunity> lstOpportunityIds = [Select Id FROM Opportunity 
															WHERE CreatedById =:userRecord.Id];
				List<OpportunityShare>lstOpportunityShare = new List<OpportunityShare>();
				List<Opportunity> lstOpportunityRec = [SELECT CreatedById FROM Opportunity
														WHERE External_ID_Populated__c != null];
														System.debug('OppId-->'+lstOpportunityIds);
														System.debug('oppUser==>'+lstOpportunityRec);
				for(Opportunity oppRec :lstOpportunityIds){
					for(Opportunity opp: lstOpportunityRec){
						OpportunityShare oppShare = new OpportunityShare();	
						
						//oppShare.OpportunityId  = oppRec.Id;
						//oppShare.ParentId = oppRec.Id; 
						//oppShare.UserOrGroupId = opp.CreatedById;
						//oppShare.OpportunityAccessLevel = 'All';
					    //oppShare.RowCause = Schema.oppShare.RowCause.Manual;
					    lstOpportunityShare.add(oppShare);
					}
				}
				//Database.SaveResult sr = Database.insert(oppShare);

	}*/
}