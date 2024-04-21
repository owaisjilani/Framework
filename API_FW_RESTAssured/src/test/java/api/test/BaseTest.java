package api.test;

import io.restassured.builder.RequestSpecBuilder;
import io.restassured.specification.RequestSpecification;

import static api.endpoints.Routes.base_url;

public class BaseTest {
    protected RequestSpecification requestSpec;

    public BaseTest() {
        requestSpec = new RequestSpecBuilder()
                .setBaseUri(base_url)
                .addHeader("Content-Type", "application/json")
                .build();
    }
}

