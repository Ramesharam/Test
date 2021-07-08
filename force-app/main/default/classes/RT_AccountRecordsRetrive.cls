public class RT_AccountRecordsRetrive {
    @AuraEnabled
     public static List<Account> getAccountss() {
         return [SELECT id, Name, AccountNumber, Industry, Phone FROM Account];
     }
}