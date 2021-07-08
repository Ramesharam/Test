public class RT_LeadAssignmentTriggerHandler  extends TriggerHandler{

	public override void beforeInsert(){
		System.debug('ttttttttttttt');
        assignLeadstoQueue((List<Lead>) trigger.new);
    }
    public override void afterUpdate(){
        updatingLeadOwners((List<Lead>) trigger.new , (List<Lead>) trigger.old);
    }
    private void assignLeadstoQueue(List<Lead> newLeadRecord){
    	//map<id,Integer> mapLeadCount  =  new map<id,Integer>();
    	//List<id> LeadOwnerId  =  new List<id>();
    	//for(Lead leadRec : newLeadRecord){
    	//	if(leadRec.OwnerId !=null)
    	//	LeadOwnerId.add(leadRec.Id);
    	//}
    	 Set<Id> setQueueIds = new Set<Id>();

    	System.debug('======newLeadRecord======>'+newLeadRecord);

    	List<Group> qList = [select Id from Group where Type = 'Queue'];
        for(Group qIds : qList){
            setQueueIds.add(qIds.Id);
        }
    	//for(Lead LeadCount : [select Id, OwnerId from Lead  WHERE OwnerId  IN : qId]){
    	//	if(mapLeadCount.containsKey(LeadCount.OwnerId)){
    	//		Integer count  =  mapLeadCount.get(LeadCount.OwnerId);
     //           mapLeadCount.put(LeadCount.OwnerId,count+1);
    	//	}
    	//	else
    	//	{
    	//		mapLeadCount.put(LeadCount.OwnerId,1);
    	//	}
    	//}
    //	for(Integer i=0; i<mapLeadCount.length-1 ; i++){
    //		for(Integer j=0;j<mapLeadCount;j++){
    //			if(mapLeadCount[i].get(mapLeadCount[i].OwnerId) < mapLeadCount[j.get(mapLeadCount[j].OwnerId)]){

				//}
    //		}
    	system.debug('-----LeadCountByQId===>'+[select OwnerId, count(Id)leadcount from Lead where OwnerID IN : setQueueIds  group By OwnerID]);

    	List<AggregateResult> LeadCountByQId =[select OwnerId, count(Id)leadcount from Lead where OwnerID IN : setQueueIds  group By OwnerID];
    	system.debug('-----LeadCountByQId'+LeadCountByQId);
    	Integer leastCount;
    	String LeadOwner;
    	set<Id> assignedQIds = new set<Id>();
    	leastCount = (Integer)LeadCountByQId[0].get('leadcount');
    	for(AggregateResult aggResultCount : LeadCountByQId){
    		assignedQIds.add((String)aggResultCount.get('OwnerId'));
    		system.debug('(Integer)aggResultCount.get(leadcount) <= leastCount ==>'+(Integer)aggResultCount.get('leadcount')+'<='+ leastCount);
    		if((Integer)aggResultCount.get('leadcount') <= leastCount){
    			system.debug('inside==>'+leastCount+'--'+(String)aggResultCount.get('OwnerId'));
    			leastCount = (Integer)aggResultCount.get('leadcount');
    			LeadOwner =(String)aggResultCount.get('OwnerId');
    		}
    	}
    	System.debug('-assignedQIds--'+assignedQIds);
    	for(Id qIds : setQueueIds){
    		system.debug('inside for==>'+qIds);
    		if(LeadCountByQId == null || !assignedQIds.contains(qIds)){
	    		system.debug('inside if   for==>'+assignedQIds.contains(qIds));
    			LeadOwner = qIds;
    		}
    	}
    	for(Lead leadRec : newLeadRecord){
    		leadRec.OwnerId = LeadOwner;
    	}
    }
    private void updatingLeadOwners(List<Lead> newLeadRec, List<Lead> oldLeadRec){
    		
    } 
}