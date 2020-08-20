({createItem: function(component, myItem) {
    
     var createEvent = component.getEvent("createExpense");
        createEvent.setParams({ "item": myItem });
        createEvent.fire();
     component.set("v.newItem",{'sobjectType': 'camping_Item__c',
                        'Name': '',
                        'Quantity__c': 0,
                        'Price__c': 0,
                        'packed__c': false });
}
  
     /*   var action = component.get("c.saveItem");
        action.setParams({
            "item": myItem
        }); 
       action.setCallback(this, function(response){
            var state = response.getState();
            if (state === "SUCCESS") {
                var itemList = component.get("v.items");
                itemList.push(response.getReturnValue());
                component.set("v.items", itemList);
                 component.set("v.newItem",{'sobjectType': 'camping_Item__c',
                        'Name': '',
                        'Quantity__c': 0,
                        'Price__c': 0,
                        'packed__c': false });
            }
        });
        $A.enqueueAction(action);
    }*/
})