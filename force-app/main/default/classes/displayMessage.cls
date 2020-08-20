public class displayMessage {
    
    public  string selectedOption{get;set;} 
    public Wrapper Wrapper1{get;set;}
    public list<wrapper> lstWrapper1{get;set;}
    public list<SelectOption> options{get;set;}
    
    public  displayMessage(){
        lstWrapper1 = new list<wrapper>();   
        string  jsonexample1 =  ' { "overalldata": [ {"stateName": "Andrapradesh",  "rating": "5.0" , "active": "yes" ,"Capital":"Amaravathi"}, { "stateName": "Telangana",  "rating": "4.0" ,"active": "no","Capital":"Hyderabad" }, {"stateName": "Karnataka",  "rating": "5.0" ,"active": "no","Capital":"Banglore"} , {"stateName": "Maharastra",  "rating": "4.5" ,"active": "no","Capital":"Mumbai"}] } ';
       
        Map<String, Object> mapobj1= (Map<String, Object>)JSON.deserializeUntyped(jsonexample1);
        system.debug('the Mapped and deserialized values are:'+ mapobj1); 
        Object objj1 = (object)mapobj1.get('overalldata');
        system.debug('the data value is :::'+objj1);
        string  SerilizeEmpdata1 = system.json.serialize(objj1);
        system.debug(SerilizeEmpdata1);
        lstWrapper1 =(list<wrapper>)system.json.deserialize(SerilizeEmpdata1,list<wrapper>.class);
        system.debug(lstWrapper1);
         getItems();
        
    }
    
    
    public List<SelectOption> getItems() {
        List<SelectOption> options = new List<SelectOption>();
        options.add(new SelectOption('none','--select--'));
        For(Wrapper lw :lstWrapper1)
            options.add(new SelectOption(lw.stateName,lw.stateName));
        return options;
    }
    public class Wrapper{
        public string  stateName{get;set;}
        public string  rating{get;set;}
        public string  active{get;set;}
        public string  Capital{get;set;}
    }
}