package api.test;

import api.utilities.DataReader;
import api.utilities.RestOperations;
import org.testng.annotations.Test;

import static api.endpoints.Routes.getUser;

public class PetTest extends BaseTest {
    @Test
    public void testGetEndpoint() {
        RestOperations.get(requestSpec, getUser);
    }

    @Test
    public void testPostEndpoint() throws Exception {
        String postData = DataReader.readJson("data/postData.json");
        RestOperations.post(requestSpec, "/posts", postData);
    }
}
