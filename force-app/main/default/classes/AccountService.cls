/**
 * @description Service class for handling Account business logic.
 *              Compliant with PMD rules (braces, bulkification, naming).
 */
public inherited sharing class AccountService {
  /**
   * @description Updates the description of a list of accounts.
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

    // PMD Rule: Avoid DML statements inside loops - perform bulk DML operations.
    List<Account> accountsToUpdate = [
      SELECT Id, Description
      FROM Account
      WHERE Id IN :accountIds
    ];

    if (accountsToUpdate.isEmpty()) {
      return;
    }

    for (Account acc : accountsToUpdate) {
      acc.Description = newDescription;
    }

    // Safe bulk update
    update accountsToUpdate;
  }
}
