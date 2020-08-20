public class Scheduled_device_Wrapper {
 public Scheduled_device__c SD {get;set;}
 public Schedule__c S{get;set;}
 public String room{get;set;}
 public String device{get;set;}
 
 public Scheduled_device_Wrapper(Scheduled_device__c sd,Schedule__c s,String rm,String dv)
 {
 SD=sd;
 S=s;
 room = rm;
 device = dv;
 }

}