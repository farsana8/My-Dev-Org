public class org_to_org1 {
 private final String clientId = '3MVG9d8..z.hDcPJ5X8cGsmoFJoqaROt_3f_qDn_0TFpwodtu_ved6A969E3UxRDbxl2FnwxJq70NQFOMmypF';
   private final String clientSecret = '5301732756102862400';
   private final String username = 'shahnamulla@suyati.com';
   private final String password = 'mulla2shahnagkckaAt5GWCWomXz8CiuodtL';
  public class deserializeResponse
   {
      public String id;
      public String access_token;
   }
  public String ReturnAccessToken (org_to_org1 acount)
   {
      String reqbody = 'grant_type=password&client_id='+clientId+'&client_secret='+clientSecret+'&username='+username+'&password='+password;
     Http h = new Http();
      HttpRequest req = new HttpRequest();
      req.setBody(reqbody);
      req.setMethod('POST');
      req.setEndpoint('https://ap5.salesforce.com/services/oauth2/token');
      HttpResponse res = h.send(req);
       system.debug('res%%%%%' + res);
     deserializeResponse resp1 = (deserializeResponse)JSON.deserialize(res.getbody(),deserializeResponse.class);
     system.debug('@@@@access_token@@'+resp1 );
      return resp1.access_token;
   }
     
   public static list<Contact> callgetContact (String accId)
   {
          org_to_org1 acount1 = new org_to_org1();
           String accessToken;
           accessToken = acount1.ReturnAccessToken (acount1);
           list<Contact> LstContact=new List<Contact>();
           if(accessToken != null){
           String endPoint = 'https://ap5.salesforce.com/services/apexrest/v1/getContacts/' +accId;
           //String jsonstr = ‘{“accId” : “‘ + accId+ ‘”}’;
           Http h2 = new Http();
           HttpRequest req1 = new HttpRequest();
           req1.setHeader('Authorization','Bearer '+ accessToken);
           req1.setHeader('Content-Type','application/json');
           req1.setHeader('accept','application/json');
           //req1.setBody(jsonstr);
           req1.setMethod('GET');
           req1.setEndpoint(endPoint);
           HttpResponse res1 = h2.send(req1);
           String trimmedResponse = res1.getBody().unescapeCsv().remove('\\');
           system.debug('@@@RESPONSE@@'+trimmedResponse);
           JSONParser parser = JSON.createParser(res1.getBody());
           set<Contact> contList=new set<Contact>();
            
            while (parser.nextToken() != null) {
                //Id
                
                if((parser.getCurrentToken() == JSONToken.FIELD_NAME) ){
                    Contact cont;
                    if ((parser.getCurrentToken() == JSONToken.FIELD_NAME) && (parser.getText() == 'Id')) {
                    // Get the value.
                    parser.nextToken();
                    // Compute the grand total price for all invoices.
                    string sId= parser.getText();
                    cont=new Contact();
                    cont.Id=sId;
                    system.debug('Id@@@' + sId);
                    
                    parser.nextToken();
                    if ((parser.getCurrentToken() == JSONToken.FIELD_NAME) && 
                        (parser.getText() == 'Name')) {
                        // Get the value.
                        parser.nextToken();
                        // Compute the grand total price for all invoices.
                        string sName= parser.getText();
                        cont.LastName=sName;
                        system.debug('Name@@@' + sName );
                    }
                    
                    //Phone
                    parser.nextToken();
                    if ((parser.getCurrentToken() == JSONToken.FIELD_NAME) && 
                        (parser.getText() == 'Phone')) {
                        // Get the value.
                        parser.nextToken();
                        // Compute the grand total price for all invoices.
                        string sPhone= parser.getText();
                        cont.Phone=sPhone;
                        system.debug('Phone@@@' + sPhone);
                    }
                        
                    //Fax
                    parser.nextToken();
                    if ((parser.getCurrentToken() == JSONToken.FIELD_NAME) && 
                        (parser.getText() == 'Fax')) {
                        // Get the value.
                        parser.nextToken();
                        // Compute the grand total price for all invoices.
                        string sFax= parser.getText();
                        cont.Fax=sFax;
                        system.debug('Fax@@@' + sFax);
                    }
                        
                    //Email
                    parser.nextToken();
                    if ((parser.getCurrentToken() == JSONToken.FIELD_NAME) && 
                        (parser.getText() == 'Email')) {
                        // Get the value.
                        parser.nextToken();
                        // Compute the grand total price for all invoices.
                        string sEmail= parser.getText();
                        cont.Email=sEmail;
                        system.debug('Email@@@' + sEmail);
                    }
                    
                
                }
                contList.add(cont); 
                }
                
                
                
                contList.remove(null);
                
            }
            LstContact.AddAll(contList);
            system.debug('ContList@@@@'+Json.serialize(LstContact));
            
            
           
        
        }
        return LstContact;
   }
   
   
}