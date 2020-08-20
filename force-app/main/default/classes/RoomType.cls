public class RoomType 
{
     public String rtype {get;set;}
     public List<Device__c> deviceList{get;set;}
     public RoomType(String rt, List<Device__c> dList)
     {
         rtype = rt;
         deviceList = dList;
     }
}