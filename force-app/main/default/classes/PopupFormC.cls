public class PopupFormC {
    @AuraEnabled
    public static void saveDetails (Account regForm1){ 
        INSERT regForm1;
    }
     @AuraEnabled
    public static List<Account> fetchAccount(String count){
        List<Account> actlist = new List<Account>();
        actlist = [SELECT id, Name, AccountNumber, Industry, Phone,Account_Count__c  From Account WHERE Account_Count__c=:count];
        return actlist;
    }
      @AuraEnabled
    public static List<Account> fetchAll(){
        List<Account> actlist = new List<Account>();
        actlist = [SELECT id, Name, AccountNumber, Industry, Phone,Account_Count__c  From Account];
        return actlist;
    }
}