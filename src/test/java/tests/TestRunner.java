package tests;

import com.intuit.karate.junit5.Karate;

public class TestRunner {

    @Karate.Test
    Karate getAPiTest() {
        return Karate.run("AuthToken").relativeTo(getClass());
    }
}