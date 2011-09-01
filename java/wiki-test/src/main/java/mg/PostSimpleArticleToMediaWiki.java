package mg;

import java.io.IOException;
import java.net.MalformedURLException;
import java.net.URL;
import java.util.concurrent.FutureTask;

import net.sourceforge.jwbf.core.actions.util.ActionException;
import net.sourceforge.jwbf.core.actions.util.ProcessException;
import net.sourceforge.jwbf.core.contentRep.SimpleArticle;
import net.sourceforge.jwbf.mediawiki.bots.MediaWikiBot;

/**
 * Hello MediaWiki!
 * 
 * A very simple class testing the "JWBF" framework .
 * 
 * @author Morten Granlund
 * @see <a href="http://jwbf.sourceforge.net/">JWBF Home Page</a>
 */
public class PostSimpleArticleToMediaWiki {

	/**
	 * A test method showing how to post a simple article to a media wiki site.
	 * 
	 * @param args
	 *            all command line args will be ignored
	 * @throws ActionException
	 *             Both the login and the actual post can lead to this
	 *             exception.
	 * @throws ProcessException
	 *             the post can lead to this exception.
	 * @throws IOException 
	 */
	public static void main(String[] args) throws ActionException, ProcessException, IOException {

		boolean TEST_WIKI_AVAILABILITY = true;
		
		// This is the address for a virtual machine (guest) set up locally
		// containing a test media wiki:
		MediaWikiBot bot = new MediaWikiBot(new URL("http://192.168.159.131/mediawiki/"), TEST_WIKI_AVAILABILITY); // 
		System.out.println("Wiki responded!");
		
		bot.login("morten", "mortenmortenmorten"); // user, password
		System.out.println("Logged in successfully!");
			
		// Reeeally simple article!
		SimpleArticle simpleArticle = new SimpleArticle("AnotherSite");
		simpleArticle
				.setText("I Scripted this Article using Java and jwbf! <br /> <br />"
						+ "Wonder if breakline tags works in simple articles?");

		// Post article!
		bot.writeContent(simpleArticle);

		System.out.println("Done!");
	}
	
}
