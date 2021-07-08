public class RT_ServiceResourceTrggerHandler extends TriggerHandler{
	public override void afterUpdate(){
        assignWorkToResource((List<ServiceResource>) Trigger.new);
    }
    //public override void afterUpdate(){
    //    populateRelatedAccountforLeads();
    //}
    private void assignWorkToResource(List<ServiceResource> newSRRecord){
		Set<ID> sResourceIds = new Set<ID>();
		for(ServiceResource SR : newSRRecord){
			sResourceIds.add(SR.Id);
		}
		Map<Id,AssignedResource> assignedResourceMap = new Map<Id,AssignedResource>([
											SELECT Id,ServiceResourceId,ServiceAppointmentId
											FROM AssignedResource
											WHERE ServiceResourceId IN : sResourceIds]);
	}
}