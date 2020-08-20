({
  
	packItem : function(component, event, helper) {
     
        var cmp=component.get("v.item");
        cmp.packed__c=true;
		component.set("v.item",cmp);    
        var btnClicked = event.getSource(); 
        butnClicked.set("v.disabled","true" );
  
	}
})