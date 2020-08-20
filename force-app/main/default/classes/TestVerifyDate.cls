@isTest
public class TestVerifyDate {
 @isTest static void testTaskPriority() {
     Date myDate = Date.newInstance(2018, 8, 15);
     Date myDate2 = Date.newInstance(2018, 9, 2);
      date  pri = VerifyDate.CheckDates(myDate,myDate2);
     System.assertEquals( myDate2, pri,'error');
//      Date myDate = Date.newInstance(2018, 8, 15);
     Date myDate3 = Date.newInstance(2019, 3, 3);
        Date myDate4 = Date.newInstance(2018, 8, 31);
      date  pro = VerifyDate.CheckDates(myDate,myDate3);
     System.assertEquals( mydate4, pro,'error');
    }
}