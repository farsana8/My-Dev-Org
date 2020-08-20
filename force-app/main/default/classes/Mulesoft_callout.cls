global class Mulesoft_callout {
     public  static List<responce> responseList{get;set;}
    //public static String callout_result;
    public  static List<account> account_list{get;set;}
 @future (callout=true) 
webservice static void GetCallout(id accid) {
    
   final String serviceEndpoint= 'http://exchangeversion2-emxc.us-e2.cloudhub.io/trigger1/';
        account_list=new List<account>();
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint(serviceEndpoint);
        request.setMethod('GET');
        HttpResponse res = http.send(request);
        system.debug('Response.statusCose::: '+res.getStatusCode() );
        if (res.getStatusCode() == 200)
        {
           // Map<String, Object> results = (Map<String, Object>) JSON.deserializeUntyped(response.getBody());
           responseList = (List<responce>)JSON.deserialize(res.getBody(), list<responce>.class);
            System.debug('results:::'+responseList);
            for(responce r:responseList)
            {
               if(r.id ==accid)
               {
                   account a=new account(id=r.id,Annual_Revenue_INR__c=r.Annual_Revenue);
                   account_list.add(a);
               }
             
            }
            System.debug(' account_list::'+account_list.size());
           if(account_list.size()==0)
           {
               account a=new account(id=accid,Annual_Revenue_INR__c=0);
                   account_list.add(a);
           
           }
           update account_list;
        }
    
    }
    public class responce{
        Public String Id{get;set;}
        public String Name{get;set;}
        public Decimal Annual_Revenue{get;set;}
    
    }
}