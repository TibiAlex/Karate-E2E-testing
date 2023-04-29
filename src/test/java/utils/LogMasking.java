package utils;

import com.intuit.karate.http.HttpLogModifier;

import java.util.regex.Pattern;

public class LogMasking implements HttpLogModifier {

    public static final HttpLogModifier INSTANCE = new LogMasking();
    private String imsPattern = ".*";

    @Override
    public boolean enableForUri(String uri) {
        return true;
    }

    @Override
    public String uri(String uri) {
        return uri;
    }

    @Override
    public String header(String header, String value) {
        if (header.toLowerCase().contains("authorization") ||
                header.toLowerCase().contains("x-gw-authorization-token") ||
                header.toLowerCase().contains("x-api-key")) {
            return "****";
        }
        return value;
    }

    @Override
    public String request(String uri, String request) {
        if (Pattern.matches(imsPattern, uri))
            return "****";
        else
            return request;
    }

    @Override
    public String response(String uri, String response) {
        if (Pattern.matches(imsPattern, uri)) {
            return "****";
        } else {
            return response;
        }
    }
}