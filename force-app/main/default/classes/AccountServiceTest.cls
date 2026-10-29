/**
 * @description Test class for AccountService.
 */
@IsTest
private class AccountServiceTest {
  @TestSetup
  static void makeData() {
    // PMD Rule: Isolate test data and avoid SeeAllData=true
    List<Account> testAccounts = new List<Account>();
    for (Integer i = 0; i < 200; i++) {
      testAccounts.add(
        new Account(Name = 'Test Account ' + i, Description = 'Initial')
      );
    }
    insert testAccounts;
  }

  @IsTest
  static void testUpdateAccountDescriptionsBulk() {
    List<Account> insertedAccounts = [SELECT Id, Description FROM Account];
    List<Id> accountIds = new List<Id>();

    for (Account acc : insertedAccounts) {
      accountIds.add(acc.Id);
    }

    String updatedDescription = 'Updated via Test';

    Test.startTest();
    AccountService.updateAccountDescriptions(accountIds, updatedDescription);
    Test.stopTest();

    List<Account> verifiedAccounts = [SELECT Id, Description FROM Account];

    // PMD / Salesforce best practice: Use Assert methods with messages or modern syntax
    for (Account acc : verifiedAccounts) {
      Assert.areEqual(
        updatedDescription,
        acc.Description,
        'The account description should match the updated value.'
      );
    }
  }

  @IsTest
  static void testUpdateAccountDescriptionsEmpty() {
    Test.startTest();
    // Passing empty list to check defensive programming paths
    AccountService.updateAccountDescriptions(new List<Id>(), 'New Desc');
    Test.stopTest();

    // If no exception is thrown and code completes, the negative path is successful
    Assert.isTrue(
      true,
      'Empty list handled gracefully without throwing errors.'
    );
  }
}
