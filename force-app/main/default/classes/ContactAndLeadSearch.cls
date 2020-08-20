public class ContactAndLeadSearch {
    public static void searchRes(String name)
   {
         List<List< SObject>> finalres=searchContactsAndLeads(name);
        System.debug('Final Result'+finalres);
   }

public static List<List< SObject>> searchContactsAndLeads(String name)
{
   List<List< SObject>> check=[FIND :name RETURNING Contact(Firstname),Lead(Firstname)];
    return check;
}
    
}