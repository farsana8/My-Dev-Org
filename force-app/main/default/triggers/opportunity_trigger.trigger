trigger opportunity_trigger on Opportunity (before insert,before update) {
    list<opportunity> opplist=new list<opportunity>();
 for (Opportunity opp : Trigger.new) {
      Boolean changed =false;
    if(trigger.isupdate)
    {
      Opportunity oldOpp = Trigger.oldMap.get(opp.Id);
        system.debug('oldopp'+oldopp);
      String newOppstage= opp.StageName;
      String oldOppstage = oldOpp.StageName;
        changed= newOppstage.equals(oldOppstage);
        system.debug('newOppstage@@'+newOppstage);
        system.debug('oldOppstage@@'+oldOppstage);
        system.debug('changed@@'+changed);
    }
    
    // Check that the field was changed to the correct value
    if (!changed) {
        System.debug(system.now());
      opp.stage_time__c = system.now();
        opplist.add(opp);
    }
     
}
   // upsert opplist;
}