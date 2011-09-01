package mg.jz11.yaa;

import static mg.juan.Notify.*;
import static org.junit.Assert.assertTrue;
import mg.juan.annotations.Notification;

import org.junit.Test;

public class AppTest {

	/**
	 * Replace the mock notifier in the annotation with another (or delete to use default) to 
	 * actually send notifications. 
	 */
	@Test
	@Notification(recipient = "morten.granlund@capgemini.com", subject = "E-mail subject")
	public void mailMeWhen() {
		notifyIf("You've been notified!", true);
		assertTrue("You broke the build, you fool!", Math.random() > 1.0);
	}

}
