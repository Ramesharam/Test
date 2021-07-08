public class RT_classForCustomButton {
    Public List<Account> acc {get; set;}
    public List<wrapAccount> customList {get; set;}
    
    public RT_classForCustomButton(){
         Id currentRecordId  = ApexPages.CurrentPage().getparameters().get('id');
        System.debug('>>>>>>'+currentRecordId);
        if(customList == null) {
            customList = new List<wrapAccount>();
            for( Account a : [select Id, Name, (SELECT firstname, lastname from Contacts ) FROM Account ORDER BY Name Limit 5]) {
               	System.debug('---'+a);
                System.debug('>>>>>>>>>'+a.Contacts+'<<<<<');
					customList.add(new wrapAccount(a)); 
                for(Contact c:a.Contacts){
                  customList.add(new wrapAccount(c));         
                }
            }
        }
        System.debug('Custom------'+customList);
    }
     public class wrapAccount {
        public Account acc {get; set;}
        public Contact con{get; set;}
        public wrapAccount(Account a) {
            acc = a;

        }
          public wrapAccount(Contact b) {
            con = b;

        }
       
    }

}