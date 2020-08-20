trigger DeviceUsageTrigger on Usage__c (after update) 
    {
        List<device__c> dev = new List<device__c>();
        dev=[select id,Usage__c from device__c ];
        for(Usage__c a : Trigger.New) 
        {
           for(device__c d: dev)
            {
                if(a.device__c==d.id)
                {
                    IF(((a.End_time__c).month() == (datetime.now()).month()) && ((a.End_time__c).year() == (datetime.now()).year()))
                        d.Usage__c=d.Usage__c+a.Duration__c; 
                }
            }
        }
        update dev;
    }