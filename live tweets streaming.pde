import twitter4j.conf.*;
import twitter4j.*;
import twitter4j.auth.*;
import twitter4j.api.*;
import java.util.*;

Twitter twitter;
String searchString = "refugees";
List<Status> tweets;

int currentTweet;

void setup()
{
    //size(800,600);
    fullScreen();
 ConfigurationBuilder cb = new ConfigurationBuilder();
    cb.setOAuthConsumerKey("your consumer key here");
    cb.setOAuthConsumerSecret("your consumer secret here");
    cb.setOAuthAccessToken("your acces token here");
    cb.setOAuthAccessTokenSecret("your acces token secret here");

    TwitterFactory tf = new TwitterFactory(cb.build());

    twitter = tf.getInstance();

    getNewTweets();

    currentTweet = 0;

    thread("refreshTweets");
}

void draw()
{
    fill(0, 40);
    rect(0, 0, width, height);

    currentTweet = currentTweet + 1;

    if (currentTweet >= tweets.size())
    {
        currentTweet = 0;
    }

    Status status = tweets.get(currentTweet);

    fill(200);
    text(status.getText(), random(width), random(height), 300, 200);

    delay(1000);
}

void getNewTweets()
{
    try
    {
        Query query = new Query(searchString);

        QueryResult result = twitter.search(query);

        tweets = result.getTweets();
    }
    catch (TwitterException te)
    {
        System.out.println("Failed to search tweets: " + te.getMessage());
        System.exit(-1);
    }
}

void refreshTweets()
{
    while (true)
    {
        getNewTweets();

        println("Updated Tweets");

        delay(30000);
    }
}
