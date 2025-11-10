import java.io.*;
import java.net.*;

public class Server {
    public static void main(String[] args) throws IOException {
        int port = 5000;
        ServerSocket serverSocket = new ServerSocket(port);
        System.out.println("Listening on port " + port);

        while (true) {
            Socket socket = serverSocket.accept();
            BufferedReader in = new BufferedReader(new InputStreamReader(socket.getInputStream()));
            BufferedWriter out = new BufferedWriter(new OutputStreamWriter(socket.getOutputStream()));
            String line = in.readLine();
            if ("HELLO".equals(line)) {
                out.write("OLLEH SRV1\n");
            } else {
                out.write("UNKNOWN\n");
            }
            out.flush();
            socket.close();
        }
    }
}
