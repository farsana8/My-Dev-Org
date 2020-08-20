public class tryactioncontroller {
Public string Display{get;set;}
    public integer count{get;set;}
    Public tryactioncontroller(){
     Display = 'value set in constructor';
        count=0;
    }
    
    Public void act(){
      Display = 'value set in action function method';
    }
     public PageReference incrementCounter() {
            count++;
            return null;
    }
 
    Public void acti(){
      Display = 'value set in action Support method';
        System.debug('value set in action Support methods');
    }
}