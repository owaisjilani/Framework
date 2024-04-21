package api.utilities;

import io.restassured.response.ValidatableResponse;

import static org.hamcrest.Matchers.equalTo;

public interface ResponseValidator {
    void validate(ValidatableResponse response);
}

