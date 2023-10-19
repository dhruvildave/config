import java.io.*;
import java.util.*;

public class Main {
    private static void soln() throws IOException {
    }

    public static void main(String[] args) throws IOException {
        var t = 1L;
        t = BufIO.read(Long.class); // comment if only 1 test case

        for (var i = 0; i < t; i++) {
            soln();
        }

        BufIO.close();
    }
}

class BufIO {
    private static final BufferedReader in = new BufferedReader(new InputStreamReader(System.in));
    private static final BufferedWriter out = new BufferedWriter(new OutputStreamWriter(System.out));

    public static <T> ArrayList<T> read(Class<T> cls, long n) throws IOException {
        if (cls != Long.class && cls != Double.class && cls != String.class && cls != Boolean.class) {
            throw new IOException("only supported long | double | string | bool");
        }

        var arr = new ArrayList<T>(Math.toIntExact(n));

        var st = new StringTokenizer(in.readLine());
        if (st.countTokens() != n) {
            throw new IOException("too less or too many elements");
        }

        if (cls == Long.class) {
            while (st.hasMoreTokens()) {
                arr.add(cls.cast(Long.parseLong(st.nextToken())));
            }
        } else if (cls == Double.class) {
            while (st.hasMoreTokens()) {
                arr.add(cls.cast(Double.parseDouble(st.nextToken())));
            }
        } else if (cls == Boolean.class) {
            while (st.hasMoreTokens()) {
                arr.add(cls.cast(Boolean.parseBoolean(st.nextToken())));
            }
        } else {
            while (st.hasMoreTokens()) {
                arr.add(cls.cast(st.nextToken()));
            }
        }

        return arr;
    }

    public static <T> T read(Class<T> cls) throws IOException {
        if (cls != Long.class && cls != Double.class && cls != String.class && cls != Boolean.class) {
            throw new IOException("only supported long | double | string | bool");
        }

        var st = new StringTokenizer(in.readLine());
        if (st.countTokens() != 1) {
            throw new IOException("too less or too many elements");
        }

        T val;
        if (cls == Long.class) {
            val = cls.cast(Long.parseLong(st.nextToken()));
        } else if (cls == Double.class) {
            val = cls.cast(Double.parseDouble(st.nextToken()));
        } else if (cls == Boolean.class) {
            val = cls.cast(Boolean.parseBoolean(st.nextToken()));
        } else {
            val = cls.cast(st.nextToken());
        }

        return val;
    }

    public static <T> void write(T val) throws IOException {
        out.write(String.valueOf(val));
    }

    public static void close() throws IOException {
        in.close();
        out.close();
    }
}
