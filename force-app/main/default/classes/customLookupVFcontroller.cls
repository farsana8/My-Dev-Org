public class customLookupVFcontroller {
    private final contact con;
    public string parentid{get;set;}
    public string passedParentid{get;set;}
public customLookupVFcontroller(ApexPages.StandardController stdController) {
      this.con = (contact)stdController.getRecord();
      parentid=  ApexPages.currentPage().getParameters().get('parentid');
    system.debug('parent'+parentid);

    }
    public void setParentId()
    {
        if(passedParentid!='')
         con.Parent_Account__c= passedParentid;
        else
         con.Parent_Account__c=null;
        system.debug('con@@@@@@@@@@@@@'+con);
    }
}