global class Batchclass implements Database.Batchable<sObject>, Database.Stateful, Schedulable {
    global Integer recordsProcessed = 0;
    global Database.QueryLocator start(Database.BatchableContext bc) {
        return Database.getQueryLocator('select id,industry,rating, name from account where industry=\'Energy\'');
    }
    global void execute(Database.BatchableContext bc, List<Account> scope){

      
        for (Account account : scope) {
                    account.rating='Hot';
                recordsProcessed = recordsProcessed + 1;
            }
        update scope;
    }    
    global void finish(Database.BatchableContext bc){
        System.debug(recordsProcessed + ' records processed!!');
        AsyncApexJob job = [SELECT Id, Status, NumberOfErrors, 
            JobItemsProcessed,
            TotalJobItems, CreatedBy.Email
            FROM AsyncApexJob
            WHERE Id = :bc.getJobId()];
         System.debug(' job'+job);      
    }
global void execute(SchedulableContext ctx) {
       BatchClass Batch = new BatchClass(); 
     Database.executeBatch(Batch,2);
    }    
}