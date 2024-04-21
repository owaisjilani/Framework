package api.utilities;

import io.restassured.response.ValidatableResponse;

public class StatusAndContentTypeValidator implements ResponseValidator {
    private final int expectedStatusCode;
    private final String expectedContentType;

    public StatusAndContentTypeValidator(int expectedStatusCode, String expectedContentType) {
        this.expectedStatusCode = expectedStatusCode;
        this.expectedContentType = expectedContentType;
    }

    @Override
    public void validate(ValidatableResponse response) {
        response.statusCode(expectedStatusCode)
                .contentType(expectedContentType);
    }
}
