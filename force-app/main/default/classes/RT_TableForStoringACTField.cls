public class RT_TableForStoringACTField { 
    public Integer total_size;
    public Integer pageSize = 5;
    public Integer counter = 0;
    public Boolean isinEdit {get;set;}
     public List<wrapAccount> wrapAccountList {get; set;}
    public List<Account> actObjectforDataFetch { get; set; }
    public set<Id> editableIds= new set<Id>();
    public Id editId {get; set;}
    public Id saveId {get; set;}
    public Id cancelId {get; set;}
    public Id deleteId {get; set;}
    public List<Contact> siteLocationData {get; set;}

    public RT_TableForStoringACTField(){
        siteLocationData = [Select Id, FirstName From Contact LIMIT 5];
        isinEdit = true;
       // executeFetchData(counter);
        total_size = [SELECT count() FROM Account];
        if(wrapAccountList == null) {
            wrapAccountList = new List<wrapAccount>();
            for(Account a: [select Id, Name, AccountNumber, Industry, Phone from Account ORDER By Name limit 5 OFFSET:Counter]) {
                wrapAccountList.add(new wrapAccount(a));
            }
        }
    }
    public void isInEdit(){
        editableIds.add(editId);
        if(editableIds.contains(editId)){
            isInEdit = True;
            System.debug('Entering if');
        }
        else{
                        System.debug('not Entering if');

           isInEdit = False;
        }
        system.debug('----->'+isInEdit+'<-----');
        
    }
    public PageReference Deleterow(){
        Integer rowNumber = Integer.valueOf(ApexPages.currentPage().getParameters().get('index'));
        if(math.mod(rowNumber,pageSize) != 0){
            System.debug(wrapAccountList.remove((math.mod(rowNumber,pageSize)-1)));
        }
        else{
            System.debug(wrapAccountList.remove(pageSize-1));
        }
        //executeFetchData(counter);
        
        return null;
    }
    public PageReference Editrow(){
       for(wrapAccount wrapAccountObj : wrapAccountList){
            if(wrapAccountObj.acc.id == editId ){
                wrapAccountObj.selected = False;
            }

        }
        return Null;
    }
    public PageReference Save(){
       	Account ob = new Account();   
        for(wrapAccount wrapAccountObj : wrapAccountList){
            if(wrapAccountObj.acc.id == saveId ){
                wrapAccountObj.selected = TRUE;
                ob.id = saveId;
                ob.Name = wrapAccountObj.acc.Name;
                ob.AccountNumber = wrapAccountObj.acc.AccountNumber;
                ob.Industry = wrapAccountObj.acc.Industry;
                ob.Phone = wrapAccountObj.acc.Phone;
            }
        }
        Update ob;
        return Null;        
    }
    public PageReference Cancel(){
        for(wrapAccount wrapAccountObj : wrapAccountList){
            if(wrapAccountObj.acc.id == cancelId ){
                wrapAccountObj.selected = TRUE;
            }
        }
        executeFetchData(counter);
        return Null;
    }
    public PageReference First(){
        counter = 0;
        executeFetchData(counter);
        return null;
    }
    public PageReference Previous(){
        counter-=pageSize;
        executeFetchData(counter);
        return null;
    }
    public PageReference Next(){
        counter += pageSize;
        executeFetchData(counter);
        return null;
    }
    public PageReference End(){
        counter = total_size - math.mod(total_size, pageSize);
        executeFetchData(counter);
        return null;
    }
    Private void executeFetchData(Integer count){
        wrapAccountlist.clear();
        for(Account a: [select Id, Name, AccountNumber, Industry, Phone from Account ORDER By Name limit 5 OFFSET:Count]) {
                wrapAccountList.add(new wrapAccount(a));
            }
    }
    public Boolean getDisabledPrevious() {           
        if(counter>0)
            return false;
        else 
            return true;
    }
    public Boolean getDisabledNext() {        
        if (counter + pageSize < total_size) 
            return false; 
        else 
            return true;
    }
    public Integer getTotal_size() {
        return total_size;
    }
    public Integer getPageNumber() {
        return counter/pageSize + 1;
    }
    public Integer getTotalPages() {
        if (math.mod(total_size, pageSize) > 0) {
            return total_size/pageSize + 1;
        } 
        else {
            return (total_size/pageSize);
        }
    }
    public Integer getCounter(){
        return counter;
    }
    public class wrapAccount {
        public Account acc {get; set;}
        public Boolean selected {get; set;}
 
        public wrapAccount(Account a) {
            acc = a;
            selected = True;
        }
    }
    public PageReference emailDelRegidtration(){
        System.debug('=====>'+siteLocationData);
        //Update siteLocationData;
        return null;
    }
}