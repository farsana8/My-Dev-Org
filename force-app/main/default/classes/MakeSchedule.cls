global class MakeSchedule implements Schedulable 
{
    public String UR;
    List<Scheduled_Device__c> sh; 
    List<Usage__c> usag;
    global boolean bln;
    Device_External_Manager DEM=new Device_External_Manager();
    global MakeSchedule(List<Scheduled_Device__c> Final_D_list,boolean bl)
    {
        UR=DEM.getport(Final_D_list,bl);
        bln=bl;
        sh=Final_D_list;
    }
    global void execute(SchedulableContext ctx) 
    {
        if(sh!=NULL)
        {  
            integer flag;
            usage__c usage=new usage__c();
            usag = [select Device__c,Start_Time__c,End_Time__c,id,duration__c from Usage__c where  End_Time__c=NULL];
            list<usage__c> usage_list=new  list<usage__c>();
            if(bln==true)
            {
                for(Scheduled_Device__c sc : sh)  
                {
                    flag=0;
                    for(Usage__c u: usag)
                    {
                        if(u.Device__c==sc.Device__c)
                            flag=1;
                    }
                    if(flag==0)
                    {
                        usage=new usage__c();
                        datetime myDateTime = datetime.now();       
                        usage.Start_time__c = myDateTime  ;
                        usage.Device__c=sc.Device__c;
                        //System.debug(' usage....'+ usage);
                        usage_list.add(usage);
                    }
                    System.debug('sc.Device__c.....'+sc.Device__c);
                }
                System.debug('usage_list.....'+usage_list);
                System.debug('device_list.....'+sh);
                insert usage_list;
            }
            else if(bln==false)
            {
                for(Scheduled_Device__c sc : sh)  
                {
                    for(Usage__c u: usag)
                    {
                        if(u.Device__c==sc.Device__c)
                        {
                            usage=new usage__c();
                            datetime myDateTime = datetime.now();
                            usage.id=u.id;
                            usage.End_time__c = myDateTime;
                            double milliSeconds =  usage.End_Time__c.getTime() - u.Start_Time__c.getTime();
                            double mint = milliSeconds/60000;
                            usage.duration__c = mint;
                            usage_list.add(usage);
                        }
                    }
                }
                update  usage_list; 
            }
        }
        // DEM.makeGetCallout(UR);
        System.debug('URL@@'+UR);
        Device_External_Manager.makeGetCallout(UR);
    }   
    public string cron_exp(datetime dt)
    {       
        string exp=String.valueOf(dt.second())+' '+String.valueOf(dt.minute())+' '+String.valueOf(dt.hour())+' '+String.valueOf(dt.day())+' '+String.valueOf(dt.format('MMM'))+' ? '+String.valueOf(dt.year());
        return exp;
    }
}