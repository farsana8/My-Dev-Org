public class regrex_group 
{
   public static void regular(Parsetest__c a)
      {
        String mystring=a.parse_Value__c;
        Id cid=a.Account__c;
      // Pattern p =pattern.compile('\\{!([a-zA-Z0-9_]*)\\.([a-zA-Z0-9]*)\\}');
          Pattern p =pattern.compile('\\{!([a-zA-Z0-9_]*)\\.([a-zA-Z0-9]*(__c)*)(__[A-Z0-9]*)*\\}');
         Matcher m=p.matcher(mystring);
    
        while(m.find())
        {
              System.debug('m.group(0)' + m.group(0));
              System.debug('m.group(1)' + m.group(1));
             System.debug('m.group(2)' + m.group(2));
            //f(m.group(1)=='Account')
             if(m.group(1).equalsIgnoreCase('Account'))
                cid=a.Account__c;
              else if(m.group(1).equalsIgnoreCase('contact'))   
                  cid=a.Contact__c;
               else if(m.group(1).equalsIgnoreCase('lead')) 
                   cid=a.Lead__c;
             System.debug('m.groupCount()' + m.groupCount());
           
            sobject accountList = Database.query('SELECT ' + m.group(2)+ ' FROM '+m.group(1)+' where Id =\'' +cid +'\'');
            if(m.group(4)!=NULL)
            {
              map<String,string> date_format=new map<string,string>();
                date_format.put('__T1','MMMM dd, YYYY hh:mm a');
                date_format.put('__T2','MM/dd/YYYY hh:mm a');
                date_format.put('__T3','yyyy-MM-dd-HHmmss');
                date_format.put('__D1','MMMM dd, YYYY');
                date_format.put('__D2','MM/dd/YYYY');
                date_format.put('__D3','yyyy-MM-dd');
                
            datetime d=(datetime)accountList.get(m.group(2));
                System.debug('group(4)'+m.group(4));
                System.debug('map'+date_format);
                System.debug('format String'+date_format.get(m.group(4)));
               a.test_value__c=(string)d.format(date_format.get(m.group(4)));
            }
            else
              a.test_value__c=(String)accountList.get(m.group(2));
        }	
      
    
    }
    
}