package customJava;

import com.intuit.karate.junit5.Karate;

public class JavaRunner {

    @Karate.Test
    Karate getAPiTest() {
        return Karate.run("JavaProject").relativeTo(getClass());
    }
}
