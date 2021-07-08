public class RT_scrollableContactApxcls {
    
        @AuraEnabled
        public static List<Contact> fetchContacts(){
        List<Contact> cntlist = new List<Contact>();
        cntlist = [SELECT id, FirstName, LastName, Phone, Email FROM Contact];
        return cntlist;
   
    }
}