/**
* @ClassName:       OrgLimitclass
* @author:          Anup     
* @Created Date:    04-10-2019
*/

public class OrgLimitclass {
   
    @AuraEnabled
    
    public static List<wrapperReturn> limitMethod(){
        List<System.OrgLimit> limits = OrgLimits.getAll();
        List<wrapperReturn> returnWrapper = new List<wrapperReturn>();
        for (System.OrgLimit aLimit: limits) {
            returnWrapper.add(new wrapperReturn(aLimit));
        }
        return returnWrapper;
    }
    /**
    * @ClassName       wrapperReturn
    * It calculates the percentage of org limits to display on the progree bar
    */
    public class wrapperReturn {
        @AuraEnabled public String label;
        @AuraEnabled public double value;
        @AuraEnabled public Integer maxLimit;
        @AuraEnabled public Integer usedLimit;
        @AuraEnabled public double percentage;
        
        public wrapperReturn(System.OrgLimit a) {
            label       = a.getName();
            maxLimit    = a.getLimit();
            usedLimit   = a.getValue();
            calculatePercentage();
        }
        public void calculatePercentage(){
            if(maxLimit == 0 ){
                percentage = 0;
            }else{               
                percentage = (usedLimit*100)/maxLimit;
            }
            value = percentage;
        }
    }
    }