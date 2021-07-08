public class MemberCardSwipeController {
    
    // sample card scan read
    // %B6201112223374015^TEST/USER.^1802101000004010000000000000001?;6201111234567890=18021010000040100000?
    // member number 6201111234567890
    
    public String cardScanString { get; set; }
    
    public PageReference searchVf() {        
        
      /* 
        // get the member number 
        String memberCardNum = parseCardScan(this.cardScanString);
        system.debug('membercardnumber::' + memberCardNum);
        
        String query ='SELECT Id, Name,AccountId FROM Contact WHERE Member_Card_Num__c =: memberCardNum limit 10';
        
        // find the contact(s)
        List<Contact> lsContact = Database.query(query);
        
        system.debug('Contacts Found [' + lsContact.size() +']= ' + lsContact);
        
        // default to the search results
        PageReference retURL = new PageReference('/' + '_ui/search/ui/UnifiedSearchResults?searchType=2&str=*' + memberCardNum + '*');              
		User currentuser =[Select Branch_Number__c from User where Id=:userinfo.getuserId()];
        RecordType rt = [SELECT Id, Name from RecordType where DeveloperName = 'Member_Card_Swipe' AND SObjectType = 'Action_Item__c'];            
        // if just one then open that contact
        If (lsContact.size() == 1) {
            retURL = new PageReference('/' + lsContact[0].Id);
            if(System.Label.Card_Swipe_Tracking == 'On'){
            Action_Item__c AICardswipe = new Action_Item__c (RecordTypeId =rt.Id,Contact__c=lsContact[0].Id, Account__c = lsContact[0].AccountId,Activity_Owner_Branch__c = currentuser.Branch_Number__c);
            insert AICardswipe;
            system.debug('AICardswipe' + AICardswipe);
            }
            
        } 
        else if(System.Label.Card_Swipe_Tracking == 'On'){
             Action_Item__c AICardswipe = new Action_Item__c (RecordTypeId =rt.Id,Subject__c = 'Membership Number:: ' + memberCardNum,Activity_Owner_Branch__c = currentuser.Branch_Number__c); 
             insert AICardswipe; 
        }        
        // redirect
        retURL.setRedirect(true);
        return retURL; 
			*/
        return null;
     }  
    
    public static String parseCardScan(String scanString) {        
        return scanString.substringBetween(';', '=');
    }    
    
}