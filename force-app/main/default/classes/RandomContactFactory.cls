public class RandomContactFactory {
public static List<Contact>  generateRandomContacts(integer num,String name)
{
    List<contact> c=new list<contact>();
    for(integer i=1;i<=num;i++)
    {
        contact con=new contact(Firstname='test'+i,lastName=name);
        c.add(con);
    }
    return c;
}
}