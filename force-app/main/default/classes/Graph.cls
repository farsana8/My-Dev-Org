public class Graph 
{
 public List<PieWedgeData> getPieData()
 	{ 
         List<PieWedgeData> data = new List<PieWedgeData>();
         List<Room__c> rm = new List<Room__c>();
         rm= [SELECT Name, Total_usage__c FROM room__c order by id];
         for(Room__c r: rm)
         { 
 			data.add(new PieWedgeData(r.Name,r.Total_usage__c));
 		 }
 		 return data;
     }
     public List<PieWedgeData> getguage()
 	{ 
         List<PieWedgeData> data = new List<PieWedgeData>();
         List<AggregateResult> ar = new List<AggregateResult>();
         ar= [select  sum(previous_usage_in_watt__c) m from device__c where Room__c='a077F000001r7rJQAQ'];
         for(AggregateResult r: ar)
         { 
 			data.add(new PieWedgeData('TOTAL USAGE',Integer.valueOf(r.get('m'))));
 		 }
 		 return data; 
     }
    public List<PieData> getBarData1()
 	{ 
         List<PieData> data = new List<PieData>();
         List<AggregateResult> ar = new List<AggregateResult>();
         ar = [select CALENDAR_MONTH(Start_time__c) m,sum(duration_in_watt__c) c from Usage__c group by CALENDAR_MONTH(Start_time__c) order by CALENDAR_MONTH(Start_time__c)];
         for(AggregateResult r: ar)
         { 
             String month= String.valueOf(r.get('m'));
             DateTime d=DateTime.valueof(r.get('m'));
             Integer Duration_in_min= Integer.valueOf(r.get('e'));
             Integer Duration_in_watt= Integer.valueOf(r.get('c'));
 			 data.add(new PieData(month,Duration_in_min,Duration_in_watt));
 		 }
 		 return data; 
     }
   public List<PieWedgeData> getBarDatas()
 	{ 
         List<PieWedgeData> data = new List<PieWedgeData>();
         List<AggregateResult> ar = new List<AggregateResult>();
           Map<Integer,String> monthMap = new Map<Integer,String>();
            monthMap.put(1,'JAN');
            monthMap.put(2,'FEB');
            monthMap.put(3,'MAR');
            monthMap.put(4,'APR');
            monthMap.put(5,'MAY');
            monthMap.put(6,'JUN');
            monthMap.put(7,'JUL');
            monthMap.put(8,'AUG');
            monthMap.put(9,'SEP');
            monthMap.put(10,'OCT');
            monthMap.put(11,'NOV');
            monthMap.put(12,'DEC');
         ar = [select CALENDAR_MONTH(Start_time__c) m,sum(duration_in_watt__c) c from Usage__c group by CALENDAR_MONTH(Start_time__c) order by CALENDAR_MONTH(Start_time__c)];
         for(AggregateResult r: ar)
         { 
            String month=  monthMap.get(Integer.valueOf(r.get('m')));
            Integer Duration_in_watt= Integer.valueOf(r.get('c'))/1000;
 			data.add(new PieWedgeData(month,Duration_in_watt));
 		 }
 		 return data; 
     }
    public List<PieData> getBarData()
 	{ 
         List<PieData> data = new List<PieData>();
         List<device__c> rm = new List<device__c>();
         rm = [SELECT Name, room__r.name,previous_usage_in_watt__c,usage_in_watt__c FROM device__c order by id];
         for(device__c r: rm)
         { 
 			data.add(new PieData(r.Name+':'+r.room__r.name,r.previous_usage_in_watt__c,r.usage_in_watt__c ));
 		 }
 		 return data; 
     }
     public class PieWedgeData
     { 
         public String name { get; set; } 
         public Decimal data { get; set; } 
         public PieWedgeData(String name, Decimal data)
         { 
             this.name = name; 
             this.data = data;
         }
     } 
    public class PieData
     { 
         public String name { get; set; } 
         public Decimal data1 { get; set; } 
         public Decimal data2{get;set;}
         public PieData(String name, Decimal data1,Decimal data2)
         { 
             this.name = name; 
             this.data1 = data1;
             this.data2=data2;
         }
     } 
}