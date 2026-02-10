import com.university.util.DBConnection;
import java.sql.Connection;

public class TestDB {
    public static void main(String[] args) throws Exception {
        Connection con = DBConnection.getConnection();
        System.out.println("CONNECTED!!!");
    }
}
