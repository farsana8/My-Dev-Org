trigger ClosedOpportunityTrigger on Opportunity (after insert,after update) {
 /* List<Task> tasklist = new List<Task>();
   for(Opportunity opps : [SELECT Id,Name FROM Opportunity WHERE Id IN :Trigger.New AND stagename='Closed Won']) 
   {
       Task tsk=new Task();
       tsk.subject='Follow Up Test Task';
       tsk.WhatId=opps.id;
       tasklist.add(tsk);
   }
    insert tasklist;*/
}