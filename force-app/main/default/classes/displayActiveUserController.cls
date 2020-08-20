public class displayActiveUserController {
@AuraEnabled
    public static list<user> getDisplayList()
    {
       
        List<user> users =new List<user>();
          users=[SELECT Name,Id FROM user];
        system.debug('userss:::::::::'+users);
        return users;
 
    }
}