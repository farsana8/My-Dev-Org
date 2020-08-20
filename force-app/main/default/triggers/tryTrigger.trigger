trigger tryTrigger on Account (after update)
{
      
        system.debug('NEW VALUE:');
        for(account a : Trigger.New) 
        {
          system.debug(a); 
        }
        system.debug('old VALUE:');
        for(account a : Trigger.old) 
        {
          system.debug(a); 
        }
     Set<ID> ids = Trigger.newMap.keySet();
      System.debug(ids);
     List<account> c = [SELECT name FROM account WHERE id in :ids];
    System.debug(c);

        
        
  
}