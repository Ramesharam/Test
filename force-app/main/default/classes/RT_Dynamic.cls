public class RT_Dynamic {
public List<Contact> contacts { get;set; }
    Public RT_Dynamic(){
            contacts=[select firstname,lastname,email,phone from Contact limit 10];
    }
   
}