public class InsertController {
    public List<Contact> contacts {get; set;}
    public String firstname { get; set; }
    public String lastname {get; set; }
    public InsertController(){
        firstname='';
        lastname='';
    }
    public void insertData(){
         System.debug('>>c>>'+firstname);
        System.debug('>>c>>'+lastname);

        Contact c=new Contact();
        c.FirstName = firstname;
        c.LastName = lastname;
        INSERT c;
        System.debug('>>c>>'+c);
    }
    
}