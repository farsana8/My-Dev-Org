({  doInit: function(component, event, helper) {
       var action = component.get("c.getItems");
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                component.set("v.items", response.getReturnValue());
            }
            else {
                console.log("Failed with state: " + state);
            }
        });
        $A.enqueueAction(action);
    },
   handleAddItem: function(component, event, helper) {
        var newItem = event.getParam("item");
       // helper.createItem(component, newItem);
         var action = component.get("c.saveItem");
        action.setParams({
            "item": newItem
        }); 
        action.setCallback(this, function(response){
            var state = response.getState();
            if (state === "SUCCESS") {
                var itemList = component.get("v.items");
                itemList.push(response.getReturnValue());
                component.set("v.items", itemList);
                /* component.set("v.newItem",{'sobjectType': 'camping_Item__c',
                        'Name': '',
                        'Quantity__c': 0,
                        'Price__c': 0,
                        'packed__c': false });*/
            }
        });
        $A.enqueueAction(action);
    }
  /*
	 clickCreateitem: function(component, event, helper) {
        var validExpense = component.find('itemform').reduce(function (validSoFar, inputCmp) {
            // Displays error messages for invalid fields
            inputCmp.showHelpMessageIfInvalid();
            return validSoFar && inputCmp.get('v.validity').valid;
        }, true);
       
        if(validExpense){
       
      
       /* var newItem = component.get("v.newItem");
        var item = component.get("v.items");
        var newExpense = JSON.parse(JSON.stringify( newItem));
 
        item.push(newExpense);
        component.set("v.items",item);
            component.set("v.newItem",{'sobjectType': 'camping_Item__c',
                        'Name': '',
                        'Quantity__c': 0,
                        'Price__c': 0,
                        'packed__c': false })*/
         /*var newItem = component.get("v.newItem");
         helper.createItem(component, newItem);
        }
    }*/
})