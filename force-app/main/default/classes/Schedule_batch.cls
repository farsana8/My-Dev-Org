global class Schedule_batch  implements Schedulable {

    global void execute(SchedulableContext ctx) {
       BatchClass Batch = new BatchClass(); 
     Database.executeBatch(Batch,2);
    }
}