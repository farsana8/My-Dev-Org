public class Device_External_Manager 
{
    public device__c dev;
    @future (callout=true) 
    public static void makeGetCallout(String status) {
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint(Label.Arduino_Endpoint+status);
        request.setMethod('GET');
        HttpResponse response = http.send(request);
        if (response.getStatusCode() == 200)
        {
            Map<String, Object> results = (Map<String, Object>) JSON.deserializeUntyped(response.getBody());
            List<device__c> updated_devices=new List<device__c>();
            updated_devices=[select id,port_number__c,status__c from device__c ];
            Set <String> deviceSet = new Set<String>();
            deviceSet = results.keySet();
            for(device__c d:updated_devices)
            {
                for (String i :deviceSet) 
                {
                    integer n=Integer.valueOf(i);
                    //object state=results.get(i);
                    String state=String.valueOf(results.get(i));
                    if(n==d.port_number__c)
                    {
                        if(state=='ON')
                            d.Status__c=true;
                        else if(state=='OFF')
                            d.Status__c=false;
                    }                  
                }
            }
            update updated_devices;
        }
    }     
    public String getport(id dev_id,boolean status)
    {   
        String url;
        device__c devs=[select port_number__c from device__c where id =: dev_id];
        
        url=getStatusCode(status)+'@{'+devs.port_number__c+'}';
        return url;
    }
    public String getport(list<Scheduled_Device__c> slist,boolean status)
    {
        list<device__c> devlist=new list<device__c>();
        devlist=[select id,port_number__c from device__c ];
        String url=getStatusCode(status)+'@'+'{';
        for(Scheduled_Device__c s: slist)
        {
            for(device__c d: devlist) 
            {
                if(s.device__c==d.id)
                    url=url+d.port_number__c+',';
            }
        }
        url=url.removeEnd(',');
        url=url+'}';
        System.debug('url##'+url);
        return url;
    }
    public String  getStatusCode(boolean current_status)
    {
        if(current_status==true)
            return ('ON');
        else if(current_status==false)
            return('OFF');
        else
            return null;
    }
    
}