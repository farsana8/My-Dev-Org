public class Schedule_wrapper 
{
    public String roomtype {get;set;}
    public List<Device_list> Selecteddevice{get;set;}
    public Schedule_wrapper(String rt, List<Device_list> dList)
    {
        roomtype = rt;
        Selecteddevice = dList;
    }
}