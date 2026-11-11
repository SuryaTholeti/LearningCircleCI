public class AccountHandler {
  /**
   * Updates the description of given accounts based on their industry.
   * //hi
   * @param accountsList List of Account sObjects to process.
   */
  public static void updateAccountDescriptions(List<Account> accountsList) {
    if (accountsList == null || accountsList.isEmpty()) {
      return;
    }

    for (Account acc : accountsList) {
      if (acc.Industry == 'Technology') {
        acc.Description = 'Priority Technology Account';
      } else if (acc.Industry == 'Finance') {
        acc.Description = 'Priority Financial Account';
      } else {
        acc.Description = 'Standard Account';
      }
    }
  }
}
