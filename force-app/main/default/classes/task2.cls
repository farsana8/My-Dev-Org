public class task2 {
public static void date_regrex()
      {
        String mystring='{!Account.SampleDate__c}';
        //Id cid=a.Account__c;
        //  Pattern p =pattern.compile('\\{!([a-zA-Z0-9_]*)\\.([a-zA-Z0-9]*(__c)*(__[A-Z]d{1}))\\}');
         Pattern p =pattern.compile('\\{!([a-zA-Z0-9_]*)\\.([a-zA-Z0-9]*(__c)*)(__[A-Z0-9]*)*\\}');
         Matcher m=p.matcher(mystring);
    
        while(m.find())
        {
              System.debug('m.group(0)' + m.group(0));
              System.debug('m.group(1)' + m.group(1));
             System.debug('m.group(2)' + m.group(2));
            System.debug('m.group(3)' + m.group(3));
            System.debug('m.group(4)' + m.group(4));
            //f(m.group(1)=='Account')
             /*if(m.group(1).equalsIgnoreCase('Account'))
                cid=a.Account__c;
              else if(m.group(1).equalsIgnoreCase('contact'))   
                  cid=a.Contact__c;
               else if(m.group(1).equalsIgnoreCase('lead')) 
                   cid=a.Lead__c;
             System.debug('m.groupCount()' + m.groupCount());
            String attr=(string)m.group(2);
            sobject accountList = Database.query('SELECT ' + m.group(2)+ ' FROM '+m.group(1)+' where Id =\'' +cid +'\'');
            a.test_value__c=(String)accountList.get(m.group(2));*/
        }	
      
    
    }
}