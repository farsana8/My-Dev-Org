public class regex {
public static void regular_ex()
    {
     String mystring='i am apple,my friend is orange ,apple, grape and pinapple';
    Map<string,string> fruit = new Map<string,string>();
    fruit.put('apple', 'red');
    fruit.put('pinapple', 'yellow');
    fruit.put('grape', 'violet');
    fruit.put('orange', 'green');
     System.debug('fruits are '+ fruit);
        Pattern p =pattern.compile('([a-zA-Z]*e)');
        	Matcher m=p.matcher(mystring);
        String newString=mystring;
        while(m.find())
        {
            System.debug('m.group(0)' + m.group(0));
             System.debug('m.groupCount()' + m.groupCount());
            if(fruit.containsKey(m.group(0)))
           mystring=mystring.replaceFirst(m.group(0), fruit.get(m.group(0)));
             System.debug('String:'+mystring);
        }	
        System.debug('String:'+mystring);
    }
	
    
}