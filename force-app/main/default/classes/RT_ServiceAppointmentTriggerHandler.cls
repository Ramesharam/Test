public class RT_ServiceAppointmentTriggerHandler extends TriggerHandler{
	public override void afterUpdate(){
        assignWorkToResource((List<ServiceAppointment>) Trigger.new);
    }
    //public override void afterUpdate(){
    //    populateRelatedAccountforLeads();
    //}
    private void assignWorkToResource(List<ServiceAppointment> newSARecord){
		Set<ID> sAppointmentIds = new Set<ID>();
		for(ServiceAppointment SAobject : newSARecord){
			sAppointmentIds.add(SAobject.Id);
		}
		Map<Id,AssignedResource> assignedResourceMap = new Map<Id,AssignedResource>();
		for(AssignedResource ARobject: [SELECT Id, ServiceResourceId, ServiceAppointmentId
											FROM AssignedResource
											WHERE ServiceAppointmentId IN : sAppointmentIds]){
			assignedResourceMap.put(ARobject.ServiceAppointmentId, ARobject);
		}
		Set<Id> SResourceIds = new Set<Id>();
		if(!assignedResourceMap.isEmpty()){
			for(ServiceAppointment SAObject : newSARecord){
				if(assignedResourceMap.containsKey(SAObject.Id)){
					SResourceIds.add(assignedResourceMap.get(SAObject.Id).ServiceResourceId);
				}
			}
		}
		Map<Id,ServiceResource> SRRecordMap = new Map<Id,ServiceResource>([SELECT Id,LastKnownLocation
																			FROM ServiceResource 
																			WHERE Id IN : SResourceIds]);
		if(!SRRecordMap.isEmpty()){
			for(ServiceAppointment SAObject : newSARecord){
				if(assignedResourceMap.containsKey(SAObject.Id)){
					if(SRRecordMap.containsKey(assignedResourceMap.get(SAObject.Id).ServiceResourceId)){
						SAObject.Location_1__c = JSON.serialize(SRRecordMap.get(assignedResourceMap.get(SAObject.Id).ServiceResourceId).LastKnownLocation);
					}

				}
			}
		}	
	}
}