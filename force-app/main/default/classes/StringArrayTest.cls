public class StringArrayTest {
public static void disp(integer num)
{
  List<String> testitem=generateStringArray(num);
    System.debug('List : '+ testitem);
}
 public static  List<String> generateStringArray(integer n)  
 {
     List<String> test=new List<String>();
     for(integer i=0;i<n;i++)
         test.add('Test '+ i);
     return test;
 }
}