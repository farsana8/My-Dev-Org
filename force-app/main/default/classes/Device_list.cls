public class Device_list 
{
     public Id dev_id {get;set;}
     public String dev_name{get;set;} 
     public boolean selected{get;set;}
     public Device_list(Id rt,String name,boolean checked)
     {
         dev_id = rt;
         dev_name=name;
         selected = checked;
  	 }
}