({
	createItem: function(component, myItem) {
       // var itemList = component.get("v.items");
        var action = component.get("c.saveItem");
        action.setParams({
            "item": myItem
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
})