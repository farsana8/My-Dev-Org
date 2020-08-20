public class taskcontroller {
    public stud__c st{get;set;}
    public list<stud__c> lst{get;set;}
    public Integer n{get;set;}
    public String grade{get;set;}
    public string cid{get;set;}
    public taskcontroller()
    {
      st=new stud__c();  
        n=0;
    }
    public void saveme()
    {
        System.debug('hh'+st);
        if(n<3)
        {
        insert st;
        st=new stud__c();  
        }
        else
       Apexpages.addMessage(new ApexPages.Message(ApexPages.SEVERITY.Error, 'Hey,class filled'));
    }
  public void showme()
    { 
        system.debug('hey'+cid);
        lst=[select name,class__c from stud__c where class__c =: st.class__c];
        n=lst.size();
        if(n>=3)
             Apexpages.addMessage(new ApexPages.Message(ApexPages.SEVERITY.warning, 'class size exceeded!!'));

    }
    public void showgr()
    {
        System.debug('Hey it worked!!!!');
        if(st.physics__c>40)
            grade='A';
        else if(st.physics__c>30)
             grade='B';
        else if(st.physics__c>20)
              grade='c';
        else
             grade='D';
       // if(st.ph)
    }
}