trigger accTrigger on Account (before insert) {
   List<account> acList = [SELECT Id,(select id from opportunities) FROM Account WHERE createddate = TODAY ];
    for(account a:acList)
    {
        if(a.opportunities.size()>2)
            trigger.new[0].addError('Two record is already created');
    }
/*  if(acList.size() > 0)
  {

      
  }*/
}