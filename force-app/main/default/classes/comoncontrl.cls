public class comoncontrl {
public  student std{get;set;}

public  comoncontrl(){
 
 std = new student();
}
 
 public void test(){
}
  
  public void save(){
  
  system.debug('the save request is::'+std.name);
  system.debug('the save request is::'+std.branch);
  }
 
 
 //Wrapperclass
 public class student{
 public string name{get;set;}
 public string branch{get;set;}
 
 public  student(){
 
 this.name ='Deepika';
 
 this.branch='Engineering';
 
 }
 }
}