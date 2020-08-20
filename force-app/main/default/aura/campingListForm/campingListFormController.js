({
	 clickCreateitem: function(component, event, helper) {
        var validExpense = component.find('itemform').reduce(function (validSoFar, inputCmp) {
            // Displays error messages for invalid fields
            inputCmp.showHelpMessageIfInvalid();
            return validSoFar && inputCmp.get('v.validity').valid;
        }, true);
       
        if(validExpense){
     
         var newItem = component.get("v.newItem");
         helper.createItem(component, newItem);
        }
    }
})