public class conVsBad {
    Contact c {get;set;}
   public Contact getContactMethod2() {
      // if (c == null) 
      c = [SELECT Id, Name FROM Contact LIMIT 1];
        return c;
    }
    public Contact getContactMethod1() {
       // if (c == null) c = [SELECT Id, Name FROM Contact LIMIT 1];
        return c;
    }
      public Contact getContactMethod3() {
        c = [SELECT Id, Name FROM Contact order by id  LIMIT 1 ];
        return c;
    }


    


}