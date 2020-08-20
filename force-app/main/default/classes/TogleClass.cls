public class TogleClass {
    
    public boolean v1 {get; set;}
   public double val {get; set;}
    public TogleClass(){
        getme();
      
        //ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Error, 'First Error Message added from apex'));
        v1 = false;
    }
    public void changeFun(){
        system.debug('v1'+v1);
        if(v1 == true){
            v1 = false;
        }
        else
            v1 = true;
    
    try
    {
        integer n=12/0;
    }
   catch(Exception e) {
            System.debug('Error!!'+e.getMessage());
          Apexpages.addMessage(new ApexPages.Message(ApexPages.SEVERITY.Error, e.getMessage()));
           // Apexpages.addMessage(new ApexPages.Message(ApexPages.SEVERITY.Error, e.getMessage()));
          // ApexPages.addMessage(new ApexPages.Message(ApexPages.severity.info,constantClass.'Hello'));
              //ApexPages.addMessages(e) ;  

 
        }
    }
      public void getme()
 	{ 
        //  data = new List<PieWedgeData>();
      //  ar = new AggregateResult();
        AggregateResult ar= [select sum(total_usage__c) s from room__c where name='Kitchen'];
         val=double.valueof(ar.get('s'));
         System.debug('TEST@@@@'+val);
       /*  for(AggregateResult r: ar)
         { 
 			data.add(new PieWedgeData('TOTAL USAGE',Integer.valueOf(r.get('m'))));
             System.debug('TEST@@@@'+data);
 		 }*/
        
 		// return data; 
    }
}