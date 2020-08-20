public class account_opportunity_controller {
       public String Val{get;set;}
       public List<SelectOption> opt {get;set;}
       public list<Account> accList {get;set;}
       public list<Account> acc_final_list{get;set;}
       public list<contact> con_list{get;set;}
       public list<opportunity> opp_list{get;set;}
       public account_opportunity_controller()
       {
           accList=[select id,name from account limit 100];
       }
       public List<SelectOption> getItems() {
         opt = new List<SelectOption>();
          accList=[select id,name from account limit 100];
         opt.add(new SelectOption('none','--select--'));
           for(Account a:accList)
            opt.add(new SelectOption(string.valueof(a.id),a.name));
         return opt;
        }
       public void changeList()
       { 
        id accid=id.valueof(Val);
       System.debug(accid);
           con_list=new list<contact>();
           opp_list=new list<opportunity>();
           con_list=[select id, name from contact where accountId=: accid];
           opp_list=[select id, name from opportunity where accountId=: accid];
                  
       }
  
}