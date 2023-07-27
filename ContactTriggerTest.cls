@isTest
public class ContactTriggerTest {
    @testSetup static void methodName() {
        Account acc = new Account();
        acc.Name = 'Test Account';
        insert acc;
    }
    
    @isTest
    static void testContactTrigger() {
        Account acc = [Select Id from Account Limit 1];
        Contact cont = new Contact(); 
        cont.AccountId = acc.Id;
        cont.LastName = 'Customer Contact';
        cont.Contact_Type__c = 'Customer';
        insert cont;
        System.assertEquals(true, [SELECT Has_Customer__c FROM Account WHERE Id = :acc.Id].Has_Customer__c);
        
        cont.Contact_Type__c = 'Non-Customer';
        update cont;
        System.assertEquals(false, [SELECT Has_Customer__c FROM Account WHERE Id = :acc.Id].Has_Customer__c);
        
        cont.Contact_Type__c = 'Customer';
        update cont;
        System.assertEquals(true, [SELECT Has_Customer__c FROM Account WHERE Id = :acc.Id].Has_Customer__c);

    }
}