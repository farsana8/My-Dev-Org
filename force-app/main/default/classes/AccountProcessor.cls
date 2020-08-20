public class AccountProcessor {
 @future
    public static void countContacts(list<id> acc_id) {
        map<id,account> acc_list=new Map<ID, Account>([select name,id,Number_of_Contacts__c from account where id in :acc_id]);
        list<account> to_update=new list<account>();
     for(id acc: acc_id) 
     {
         list<contact> c=[select name from contact where accountid=:acc];
         account selected_acc=acc_list.get(acc);
         selected_acc.Number_of_Contacts__c=c.size();
         to_update.add(selected_acc);
               
     }
        update to_update; 
    }

}