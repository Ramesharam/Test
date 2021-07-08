@IsTest
private class ObjectLimitBarChartControllerTest {
    
    @TestSetup
    static void buildData() {
        Object_Limit__c objLim = new Object_Limit__c(
            Object_Type__c = 'Account',
            Label__c = 'Custom Fields',
            Max__c = 500,
            Remaining__c=487,
            Type__c='CustomFields'
        );
        insert objLim;    
    }
    
    @IsTest
    static void testAll() {
        String ObjectName = 'Account';
        Object_Limit__c ObjLim = [select Object_Type__c,Label__c,Max__c,Usage__c from Object_Limit__c Where Object_Type__c='Account'  limit 1];
        
        ObjectLimitBarChartController.wrappData dataMap = ObjectLimitBarChartController.getObjectLimits(ObjectName);
        ObjectLimitBarChartController.getallobjects();
        
        System.assertEquals(ObjLim.Usage__c, dataMap.chartData.get('Custom Fields'));
    }
    
}