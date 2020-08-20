public class select_option_controller {
       public String selectedVal{get;set;}
       public List<SelectOption> options {get;set;}
       public list<Account> accList {get;set;}
       public List<SelectOption> getItems() {
         options = new List<SelectOption>();
         options.add(new SelectOption('none','select a value'));
         options.add(new SelectOption('recently created','recently created'));
         options.add(new SelectOption('recently viewed','recently viewed'));
         options.add(new SelectOption('recently modified','recently modified'));
         return options;
        }
       public void changeList()
       { 
         accList=new list<account>();
         if(selectedVal=='recently created')
            accList=[select id,name,createddate from account  order by createddate desc limit 10];
           else if(selectedVal=='recently viewed')
              accList=[select id,name,LastModifiedDate from account  order by LastModifiedDate desc limit 10];
             else if(selectedVal=='recently modified')
               accList=[select id,name,LastViewedDate  from account where LastViewedDate <> NULL   order by LastViewedDate desc limit 10];
               else
                 accList=new list<account>();
       
      }
  

}