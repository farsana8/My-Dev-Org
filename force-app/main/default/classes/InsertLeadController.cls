Public with sharing class InsertLeadController {
Public string Display_This_String{get;set;}
    Public InsertLeadController (){
     Display_This_String = 'value set in constructor';
    }
   
    Public void actionFunMethod(){
      Display_This_String = 'value set in action function method';
    }
   
    Public void actionSupMethod(){
      Display_This_String = 'value set in action Support method';
    }
}