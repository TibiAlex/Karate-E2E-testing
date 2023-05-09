package customCSharp;

import com.intuit.karate.junit5.Karate;

public class CsharpRunner {
    @Karate.Test
    Karate getAPiTest() {
        return Karate.run("CsharpProject").relativeTo(getClass());
    }
}
