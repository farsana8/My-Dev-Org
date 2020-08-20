trigger OpportunityAmountTrigger on Opportunity (before insert) {
    for(Opportunity o : Trigger.New){
    if(trigger.isinsert && o.amount < 5000)
    o.addError('Amount can not be less than 5000');
    else if (Trigger.isUpdate && o.amount < 3000)
    o.adderror('Amount can not be updated to less than 3000');
 
    }
}