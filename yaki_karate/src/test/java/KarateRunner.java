import com.intuit.karate.junit5.Karate;

public class KarateRunner {

    @Karate.Test
    Karate runAllTests() {
        return Karate.run().relativeTo(getClass());
    }
}