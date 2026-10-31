/**
 * @description Service class for handling Account business logic.
 *              Enforces WITH USER_MODE to resolve ApexCRUDViolation PMD errors.
 */
public inherited sharing class AccountService {
  /**
   * @description Updates the description of a list of accounts in User Mode.
   * @param accountIds List of Account IDs to update.
   * @param newDescription Description string to apply.
   */
  public static void updateAccountDescriptions(
    List<Id> accountIds,
    String newDescription
  ) {
    if (accountIds == null || accountIds.isEmpty()) {
      return;
    }

    // Fix 1: Added WITH USER_MODE to enforce running user's CRUD/FLS permissions on SOQL
    List<Account> accountsToUpdate = [
      SELECT Id, Description
      FROM Account
      WHERE Id IN :accountIds
      WITH USER_MODE
    ];

    if (accountsToUpdate.isEmpty()) {
      return;
    }

    for (Account acc : accountsToUpdate) {
      acc.Description = newDescription;
    }

    // Fix 2: Added 'AS USER' to enforce user mode on DML operations all checks will done hii
    update as user accountsToUpdate;
  }
}
