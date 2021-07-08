public class FetchingUsers {
    public FetchingUsers(){
        Set<Id> setIds = new Set<ID>();
        for(GroupMember userIds : [SELECT UserOrGroupId FROM GroupMember where Group.Name ='Leaders']){
            setIds.add(userIds.UserOrGroupId);
            system.debug('====>'+setIds);
        }
        
        for(User userName: [Select Name From User Where Id IN:setIds]){
            System.debug('====>'+userName);
        }
    }
}