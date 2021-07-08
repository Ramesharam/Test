public class aaa {
    
    @AuraEnabled
    public static List<Contact> fetchContacts(){
        List<Contact> cntlist = new List<Contact>();
        cntlist = [SELECT id, FirstName, LastName, Phone, Email FROM Contact];
        system.debug('----'+cntlist);
        return cntlist;
    }
}