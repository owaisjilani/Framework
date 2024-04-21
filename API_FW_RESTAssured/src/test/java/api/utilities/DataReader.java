package api.utilities;

import java.nio.file.Files;
import java.nio.file.Paths;

public class DataReader {
    public static String readJson(String filePath) throws Exception {
        return new String(Files.readAllBytes(Paths.get(filePath)));
    }
}
