public class home_controller 
{
    Public device__c dev {get;set;}
    Public usage__c use{get;set;}
    public id SheddevId {get;set;}
    public integer flag {get;set;}
    public date dat{get;set;}
    public datesam__c d{get;set;}	
    Public Schedule__c Schedule {get;set;}
    Public List<Scheduled_Device__c> Scheduled_Device;
    public id chkId {get; set;}
    public boolean chkStatus {get; set;}  
    public List<RoomType> roomDevicelist {get;set;}
    public List<room__c> roomlist;
    public List<device__c> devicelist;
    public List<device__c> onlydevicelist;
    public id usage_id;
    public home_controller()
    {
        Schedule=new Schedule__c();
        room_disp(); 
        //ApexPages.addmessage(new ApexPages.message(ApexPages.severity.CONFIRM, 'First Error Message added from apex'));  
        flag=0; 
    }
    public PageReference closePopup() 
    {
        flag=0;     
        System.debug('closepopup!!');
        if(Schedule.Start_Time__c==Null || Schedule.End_Time__c==Null)
        {
            flag=1;
            Apexpages.addMessage(new ApexPages.Message(ApexPages.SEVERITY.Error, 'start time/End time is Required...!!!'));
        }
        else if(Schedule.Start_Time__c>=Schedule.End_Time__c)
        {
            flag=1;
            Apexpages.addMessage(new ApexPages.Message(ApexPages.SEVERITY.Error, 'Scheduling not possible.....start time exceeds end time!!!'));
        }
        else if(Schedule.Start_Time__c< datetime.now())
        {
            flag=1;
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Error,'Scheduling not possible...Start time already elapsed!!'));
            
        }
        else
        {
            //flag=0;
            Schedule__c S =new Schedule__c();
            S.Start_Time__c=Schedule.Start_Time__c;
            S.End_Time__c=Schedule.End_Time__c;
            try {
                flag=0;
                insert S;  
                //System.debug('SSSS'+S);
                if(S.id == null)
                {
                    Apexpages.addMessage(new ApexPages.Message(ApexPages.SEVERITY.Error, 'Error'));
                }    
                Scheduled_Device=new List<Scheduled_Device__c>();
                Scheduled_Device__c d=new Scheduled_Device__c();
                d.Device__c= SheddevId;
                System.debug('devid:'+SheddevId);
                d.Schedule__c= S.id;   
                Scheduled_Device.add(d);
                insert Scheduled_Device;
                //ApexPages.addmessage(new ApexPages.message(ApexPages.severity.CONFIRM, 'Successfully created!!'));
                schedule__c s1=[select Name,Start_Time__c,End_Time__c from schedule__c where id=:s.id];
                MakeSchedule st=new MakeSchedule(Scheduled_Device,true);
                String qwe = st.cron_exp(S1.Start_Time__c);
                String Start_job = system.schedule(S1.id, qwe, st);
                MakeSchedule ts=new MakeSchedule(Scheduled_Device,false);
                String asd= ts.cron_exp(S1.End_Time__c);     
                String End_job = system.schedule(S1.Name,asd,ts);
                Schedule=new Schedule__c();
            }
            catch(Exception e) 
            {
                flag=1;
                System.debug('Error!!'+e.getMessage());
                ApexPages.addMessages(e) ;        
            }
        }
        system.debug('flag:'+flag);
        Schedule=new Schedule__c();
        return null;
    }     
    public void showPopup() 
    {
        dev=new device__c();
        dev =[SELECT id, Name, room__r.id, room__r.name FROM device__c where id=:SheddevId];
    }
    public List<RoomType> room_disp()
    {
        roomDevicelist = new List<RoomType>();
        roomlist = [select Name,id from room__c order by id asc];
        devicelist=[select Name,room__c,status__c,usage__c from device__c ];
        for(room__c r : roomlist)
        {
            onlydevicelist = new List<device__c>();
            for(device__c d:devicelist)
            {
                if (r.id == d.room__c)
                {
                    onlydevicelist.add(d);   
                }
            } 
            roomDevicelist.add(new RoomType(r.Name,onlydevicelist));    
        }
        return roomDevicelist;
    }
    Public  void UpdateStatus()
    {
        dev = [SELECT status__c FROM Device__c WHERE Id=:chkId LIMIT 1];
        use=new Usage__c();
        Device_External_Manager Dq=new Device_External_Manager();  
        String rl=Dq.getport(chkId,chkStatus);
        //Dq.makeGetCallout(rl);
        Device_External_Manager.makeGetCallout(rl);
        if(chkStatus==True)
        {
            datetime myDateTime = datetime.now();       
            // dev.Start_Time__c = myDateTime  ;
            System.debug('Status@@@'+chkStatus);
            dev.Status__c=True;
            update dev;
            use.Start_Time__c= myDateTime;
            use.device__c=chkId;
            insert use;
        }
        else if(chkStatus==False)
        {
            use = [SELECT Start_Time__c FROM Usage__c WHERE device__c=:chkId  and end_time__c=Null ];
            if(use != NULL)
            {
                datetime myDateTime = datetime.now();
                use.End_Time__c = myDateTime  ;
                double milliSeconds =  use.End_Time__c.getTime() - use.Start_Time__c.getTime();
                double mint = milliSeconds/60000;
                use.duration__c = mint;
                dev.Status__c=False;
                update dev;
                update use;
            }
        }
        room_disp();  
    }
    public void poller_action()
    {
        roomDevicelist=room_disp();
       // return null;
    }
}

/*****************************************************************************************************************************************************
clearUsage newsched = new clearUsage();
String sch ='0 0 0 1 * ? *';  //first day of every month
String jobID = System.schedule('clear_usage', sch, newsched);

*****************************************************************************************************************************************************/