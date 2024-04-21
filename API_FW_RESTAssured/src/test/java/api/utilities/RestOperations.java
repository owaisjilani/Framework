package api.utilities;

import io.restassured.specification.RequestSpecification;
import io.restassured.response.ValidatableResponse;
import static io.restassured.RestAssured.given;

public class RestOperations {

    public static ValidatableResponse get(RequestSpecification requestSpec, String endpoint) {
        return given()
                .spec(requestSpec)  // Use the provided specification
                .when()  // Prepare for the HTTP method
                .get(endpoint)  // Perform GET request on endpoint
                .then();  // Chain for assertions
    }

    public static ValidatableResponse post(RequestSpecification requestSpec, String endpoint, String body) {
        return given()
                .spec(requestSpec)  // Use the provided specification
                .body(body)  // Attach the request body
                .when()  // Prepare for the HTTP method
                .post(endpoint)  // Perform POST request on endpoint
                .then();  // Chain for assertions
    }

    public static ValidatableResponse put(RequestSpecification requestSpec, String endpoint, String body) {
        return given()
                .spec(requestSpec)  // Use the provided specification
                .body(body)  // Attach the request body
                .when()  // Prepare for the HTTP method
                .put(endpoint)  // Perform PUT request on endpoint
                .then();  // Chain for assertions
    }

}