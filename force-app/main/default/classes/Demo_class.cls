public class Demo_class {
    list<trip__c> plan_list=new list<trip__c>();
    integer i=1;
    public void insert_list()
    {
   
      while(i<=5)
     {
       trip__c trip=new trip__c();
       trip.name='Test'+i;
       trip.no_of_people__c=i;
         trip.place__c='Singapore';
       plan_list.add(trip);
       i++;
     }
        insert  plan_list;
        display_list();
    }
     public void delete_list()
    {
    integer i=0;
     list< trip__c >  plan_list=new list< trip__c >();
        String sname='test%';
        plan_list=[select id,name from  trip__c  where name =: sname];
      delete  plan_list;
          display_list();
    }
     public void delete_list(String stud_name)
    {
    integer i=0;
     list< trip__c >  plan_list=new list< trip__c >();
       plan_list=[select id,name from  trip__c  where name =:stud_name];
      delete  plan_list;
          display_list();
    }
     public void update_list()
    {
    integer i=0;
     list< trip__c >  plan_list=new list< trip__c >();
         plan_list=[select id,name,No_of_people__c,Price__c from  trip__c where price__c=Null ];
        for( trip__c  trip: plan_list)
        {
            if(trip.no_of_people__c!=null)
            {
            if(trip.no_of_people__c<=3)
                trip.price__c=50000*trip.no_of_people__c;
                else if(trip.no_of_people__c<=5)
                    trip.price__c=40000*trip.no_of_people__c;
                   else 
                    trip.price__c=30000*trip.no_of_people__c;
            }
                
        }
     update  plan_list;
          display_list();
    }
   public void display_list()
    {
        //list< trip__c >  plan_list=new list< trip__c >();
        for( trip__c   trip:[select id,name,no_of_people__c,price__c from  trip__c order by id])
        {
          system.debug('name :' + trip.name +'   No of persons:'+ trip.no_of_people__c+'    Price'+ trip.price__c);     
        }
    }  
}