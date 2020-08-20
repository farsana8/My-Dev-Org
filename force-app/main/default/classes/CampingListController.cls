public with sharing class CampingListController {
 @AuraEnabled
    public static List<camping_Item__c> getItems() {
        // Perform isAccessible() checking first, then
        return [SELECT Id, Name, quantity__c, price__c, packed__c, CreatedDate 
                FROM camping_Item__c];
    }
    
    @AuraEnabled
    public static camping_Item__c saveItem(camping_Item__c item) {
        // Perform isUpdatable() checking first, then
        upsert item;
        return item;
    }
}