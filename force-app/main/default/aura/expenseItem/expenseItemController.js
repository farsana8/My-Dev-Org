({
    doInit : function(component, event, helper) {
        console.log('Hey!!');
        var mydate = component.get("v.expense.Date__c");
        if(mydate){
            component.set("v.formatdate", new Date(mydate));
        }
    },
})