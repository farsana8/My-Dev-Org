public class ContactSearch {
    public static void test(String lname,String code)
    {
        List<Contact> mylist=searchForContacts(lname,code);
        System.debug('Contacts'+mylist);
    }
public static List<Contact> searchForContacts(String lname,String code)
{
    //List<Contact> mylist=new List<Contact>();
    List<Contact> cont = [SELECT ID,Name from contact where LastName=:lname and MailingPostalCode=:code];
   // mylist.add(cont);

  // System.debug('Contact'+cont);
  return cont;
}
}