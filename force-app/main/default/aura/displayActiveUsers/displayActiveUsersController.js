({
	displayUser: function(component, event, helper) {
        console.log("haii..");
		var action = component.get("c.getDisplayList");
          console.log("action.."+action);
         action.setCallback(this, function(a){
              console.log("ok..");
            var state = a.getState(); // get the response state
            if(state ==="SUCCESS") {
                console.log("hey..");
                component.set("v.userList", a.getReturnValue());
            }
        });
         $A.enqueueAction(action);
	},
   chatAction: function(component, event, helper) {
        console.log("haii..");
		  console.log('Enter Here');
       
       var evt = $A.get("e.force:navigateToSObject");
        console.log('evt'+evt);
        evt.setParams({
            componentDef: "c:chatWithUser",
            //componentAttributes :{ //your attribute}
        });
       
    evt.fire();
	},
  
  Navigateto : function(component, event, helper) {
   var evt = $A.get("e.force:navigateToComponent");
   evt.setParams({
   componentDef : "c.chatWithUser",
  componentAttributes: {
   }
   });
   evt.fire();
}

    
})