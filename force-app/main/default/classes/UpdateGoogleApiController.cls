public class UpdateGoogleApiController {
 public string endpoint{get; set;}

    //Insert the new custom setting record in the database
    public void saveRecord(){
       // CREDE__GoogleAPIEndPoint__c googleKey  = [SELECT Id, name from CREDE__GoogleAPIEndPoint__c][0];
      // CREDE__GoogleAPIEndPoint__c gAPI  = new CREDE__GoogleAPIEndPoint__c();
       // gAPI.Id = googleKey.Id; 
       // gAPI.CREDE__EndpointURL__c = endpoint;
       
       // Update gAPI;
    ApexPages.AddMessage(new ApexPages.Message(ApexPages.Severity.CONFIRM,'API key value is updated Successfully.Thank you!'));
        //Redirect to new record detail page
      // return new PageReference('/' + googleKey.Id);
      // return null;
    }
}