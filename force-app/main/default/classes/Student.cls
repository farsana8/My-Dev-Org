public class Student {
    public Student__c stud{ get;set; }
    public string div{get;set;}
    public  List<Student__c> attr{ get; set; }
    public Student()
    {
        stud = new student__c();
        valueList();
    }
    public PageReference save() {
         
        try {
            System.debug('Stud@@'+stud);
            insert stud;
           valueList();
            return null;
        } catch(System.DMLException e) {
          //  ApexPages.addMessages(e);
       System.debug(e);
            return null;
        }
    
    }

    public void valueList(){
    attr = [Select Name,Age__c,course__c from Student__c order by id];
    //return attr;
}
  public void demo() {
      div = 'Old';
      System.debug('hey');
    
    }      
}