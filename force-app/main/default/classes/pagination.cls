public class pagination {
    public List<Account> accounts { get;set; }
    Public pagination(){
            accounts=[select Id,name,Type from Account];
    }
   

}