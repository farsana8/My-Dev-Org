public class Schedule_controller 
{
     Public Schedule__c Schedule {get;set;}
    // Public Id devId {get;set;}
     public List<Schedule_wrapper> DeviceSelectedlist {get;set;}
     public List<Device_list> D_list;
     public List<room__c> room_device;
    // public List<String> dev_list{get;set;}
     public List<Schedule__c> s_list{get;set;}
     Public Scheduled_Device__c Scheduled_Device {get;set;}
     public List<id> dev_ids; 
     id Schedule_id;
    // public Device_External_Manager callout=new Device_External_Manager();
     public Schedule_controller()
     {
         Schedule=new Schedule__c();
         Scheduled_Device =new Scheduled_Device__c ();
         schedule_list();
         disp_list();
     }
     public List<Schedule_wrapper> disp_list()
     {
        room_device=[select Name,id,(select Id, Name,room__c from devices__r) from room__c order by id asc];
        DeviceSelectedlist = new List<Schedule_wrapper>();
        List<Device_list> D_list=new List<Device_list>();
        for(room__c r : room_device)
        { 
            D_list = new List<Device_list>();
            for(device__c d : r.devices__r)
            {
               if (r.id == d.room__c)
                {
                  D_list.add(new Device_list(d.id,d.Name,False));
                }
            }
            DeviceSelectedlist.add(new Schedule_wrapper(r.Name,D_list));        
        }
        return DeviceSelectedlist;
    }  
    public PageReference schedule_action()
    {
        
        List<Scheduled_Device__c> Final_D_list = new List<Scheduled_Device__c>();
        System.debug('Schedule@@'+ Schedule);
        if(Schedule.Start_Time__c==NULL || Schedule.End_Time__c==NULL )
             ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Error,'Start time/End time is required..!!'));
        else if(Schedule.Start_Time__c< datetime.now())
             ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Error,'Scheduling not possible...Start time already elapsed!!'));
        else
        {  
            try
            {
                integer f=0;
                dev_ids=new list<id>();
                for(Schedule_wrapper s :DeviceSelectedlist)
                   for(Device_list dl : s.Selecteddevice)
                      if((dl.selected==True))
                        dev_ids.add(dl.dev_id); 
                system.debug('id list%%%'+dev_ids);
                if( dev_ids.size()>0)
                {
                    insert Schedule;
                    Schedule_id=schedule.id;
                    System.debug('@ @ Start time'+ Schedule.Start_Time__c);
                    System.debug('Schedule Id**@@'+ Schedule_id);
                   
                    for(Id i :dev_ids)    
                    {
                       Scheduled_Device__c Scheduled_Device = new Scheduled_Device__c();
                       Scheduled_Device.Device__c= i;
                       Scheduled_Device.Schedule__c= Schedule_id;  
                       Final_D_list.add(Scheduled_Device);
                    }
                    if(Final_D_list !=null && Final_D_list.size()>0)
                    { 
                        insert Final_D_list; 
                        ApexPages.addmessage(new ApexPages.message(ApexPages.severity.CONFIRM, 'Successfully created!!'));
                        
                         schedule__c shed1=[select Name,Start_Time__c,End_Time__c from schedule__c where id=:Schedule_id];
                        datetime S_time=shed1.Start_Time__c;
                        MakeSchedule mk=new MakeSchedule(Final_D_list,true);
                        String CR=mk.cron_exp(S_time);
                        String Start_Job=system.schedule(Schedule_id,CR, mk);
                        datetime E_time=shed1.End_Time__c;
                        MakeSchedule km=new MakeSchedule(Final_D_list,false);
                        String RC=km.cron_exp(E_time);
                        String End_Job=system.schedule(Shed1.Name,RC, km);
                    }
                }
                else 
                {
                    Apexpages.addMessage(new ApexPages.Message(ApexPages.SEVERITY.Error, 'Scheduling not possible!!Please select devices...!!!'));
                }
                System.debug('Final D List'+Final_D_list);
            }
            catch(Exception e)
            {
                ApexPages.addMessages(e) ;  
            }
            
            Schedule=new Schedule__c();
            schedule_list();
            disp_list();
         
       } 
        return null;  
    }
    
    public PageReference schedule_cancel()
    {
         disp_list();
         Schedule=new Schedule__c();
         return null;
    }
    public List<Schedule__c> schedule_list()
    {
     
        s_list = new List<Schedule__c>();
        s_list=[select Name,id,Start_Time__c,End_Time__c,(select device__r.Name,device__r.room__r.Name from Scheduled_Devices__r) from Schedule__c order by id desc Limit 3];
        return s_list;
    }
}