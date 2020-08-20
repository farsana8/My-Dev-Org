trigger RegrexTrigger on Parsetest__c (before insert,before update) {
for(Parsetest__c a : Trigger.New) 
        {
          regrex_group.regular(a); 
        }
}