public class acccon {

public void test()
{ 
  integer i;
  list <account> acc=new list<account>();
  list <contact> con=new list<contact>();
  list <opportunity> opp=new list<opportunity>();
  for(i=1;i<=3;i++)
  {
   account a=new account(name='abc'+i);
   acc.add(a) ;
   }

   for(i=1;i<=3;i++)
   { 
    contact a=new contact(lastname='con'+i);
    con.add(a) ;
   } 
   database.insert(acc, false);
   insert con;
   list<account> insertedAccounts=[select name from account where name like 'abc%'];
   system.debug('Account inserted: '+ insertedAccounts);
   list<contact> insertedContacts=[select name from contact where name like 'con%'];
   system.debug('Account inserted: '+ insertedContacts);
   for(i=1;i<=3;i++)
   { 
    opportunity a=new opportunity(name='opp'+i);
   opp.add(a) ;
   }
   insert opp;

 }
}