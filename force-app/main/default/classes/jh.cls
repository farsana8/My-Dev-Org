public class jh {
public void nullPointerException() {


 List<Account> listAccount;
 System.debug('thet is'+listAccount);
 //listAccount = [Select id, name from account limit 10];
 System.debug('thet is'+listAccount);



try {
 //Making the list null again
 listAccount = null;
 System.debug('thisl shoot error - Attempt to dereference a null pointer'+listAccount[0]);
 } catch (NullPointerException ex) {
 System.debug('Theeption came here in catch block and thats all, our code ended');
 } finally {
 System.debug('Thisally block will always get called');
 }

}

}