public class AccountHandler {
  /**
   * Updates the description of given accounts based on their industry.
   * checking the industry field and setting the description accordingly... checking if the industry is 'Technology' or 'Finance' and setting the description to 'Priority Technology Account' or 'Priority Financial Account' respectively. If the industry is neither, it sets the description to 'Standard Account'.
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
