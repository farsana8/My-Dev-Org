Public with sharing class DynamicVisualforceController {
Public String ObjectName{get;set;}
Public List<sobject> sObjectList{get;set;}
String QueryString;
Public List<string> fieldList{get;set;}
/*Constructor for class*/
    Public DynamicVisualforceController(){
      ObjectName = Label.Object_Name_Label;// strore the value of custom label in string variable
      QueryString ='Select id ,name from '+ObjectName+ ' limit 10' ;
      fieldList = New List<string>();
      fieldList.add('id');
      fieldList.add('name');
      sObjectList = Database.Query(QueryString);
    }
      
}