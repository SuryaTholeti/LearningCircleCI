@isTest
private class AccountHandlerTest {
  @isTest
  static void testUpdateAccountDescriptions() {
    // 1. Setup Test Data
    List<Account> testAccounts = new List<Account>{
      new Account(Name = 'Tech Corp', Industry = 'Technology'),
      new Account(Name = 'Bank of Apex', Industry = 'Finance'),
      new Account(Name = 'Local Store', Industry = 'Retail')
    };

    // Insert data so IDs are generated (though not strictly required for this pure logic method)
    // checking if the method can handle records with IDs, but since the method doesn't perform DML, this is optional.
    insert testAccounts;

    // 2. Execute Test logic
    Test.startTest();
    AccountHandler.updateAccountDescriptions(testAccounts);
    Test.stopTest();

    // 3. Verify Results
    System.assertEquals(
      'Priority Technology Account',
      testAccounts[0].Description,
      'Technology account description should match.'
    );
    System.assertEquals(
      'Priority Financial Account',
      testAccounts[1].Description,
      'Finance account description should match.'
    );
    System.assertEquals(
      'Standard Account',
      testAccounts[2].Description,
      'Default account description should match.'
    );
  }

  @isTest
  static void testUpdateAccountDescriptionsEmpty() {
    // Test edge case with null or empty list
    Test.startTest();
    AccountHandler.updateAccountDescriptions(null);
    AccountHandler.updateAccountDescriptions(new List<Account>());
    Test.stopTest();

    // Verify no exceptions were thrown
    System.assert(true, 'Method handled empty or null lists gracefully.');
  }
}
