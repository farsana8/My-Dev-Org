@isTest
public class TestRestrictContactByName {

    @isTest static void TestRestrict() {
        // Test data setup
        // Create an account with an opportunity, and then try to delete it
        contact con = new contact(LastName='INVALIDNAME');
       // insert con;
        
        // Perform test
        Test.startTest();
        Database.SaveResult result = Database.insert(con, false);
        Test.stopTest();
        // Verify 
        // In this case the deletion should have been stopped by the trigger,
        // so verify that we got back an error.
        System.assert(!result.isSuccess());
        System.assert(result.getErrors().size() > 0);
        System.assertEquals('The Last Name "INVALIDNAME" is not allowed for DML',
                             result.getErrors()[0].getMessage());
    }
    
}