package sort;

import org.apache.commons.cli.CommandLine;
import org.apache.commons.cli.DefaultParser;
import org.apache.commons.cli.Options;
import org.apache.commons.cli.ParseException;

import java.io.BufferedWriter;
import java.io.FileWriter;
import java.io.IOException;
import java.util.Arrays;
import java.util.Random;



public class Main {
    public static void main(String[] args) {
        Options opts = setOptions();

        CommandLine cmd = null;
        int lower = 0, upper = 0, step = 0, iter = 0;
        String outfile = "";

        try {
            var parser = new DefaultParser();
            cmd = parser.parse(opts, args);

            lower = Integer.parseInt(cmd.getOptionValue("l"));
            upper = Integer.parseInt(cmd.getParsedOptionValue("u"));
            step = Integer.parseInt(cmd.getParsedOptionValue("s"));
            iter = Integer.parseInt(cmd.getParsedOptionValue("i"));
            outfile = cmd.getOptionValue("o");
        } catch (ParseException e) {
            System.out.println("[!] error reading args: " + e);
            System.exit(1);
        }

        StringBuilder out = new StringBuilder();
        for (int n = lower; n <= upper; n += step) {
            int[] data = createArray(n);
            long elapsed = timeSort(data, iter);
            long time = elapsed / iter;
            out.append(formatTime(time, n, cmd.hasOption("o")));
        }

        writeTime(out, cmd.hasOption("o"), cmd.getOptionValue("o"));
    }

    private static Options setOptions() {
        var opts = new Options();

        opts.addRequiredOption("l", "lower", true, "lower bound");
        opts.addRequiredOption("u", "upper", true, "upper bound");
        opts.addRequiredOption("s", "step", true, "steps");
        opts.addRequiredOption("i", "iter", true, "iterations");
        opts.addOption("o", "out", true, "out file");

        return opts;
    }

    private static int[] createArray(int n) {
        int[] data = new int[n];
        var rand = new Random();

        for(int i = 0; i < n; i++) {
            data[i] = rand.nextInt(Integer.MAX_VALUE);
        }

        return data;
    }

    private static long timeSort(int[] data, int iter) {
        long start = System.nanoTime();
        int[] tmp = data.clone();

        for (int i = 0; i < iter; i++) {
            Arrays.sort(data);
            data = tmp.clone();
        }

        return System.nanoTime() - start;
    }

    private static String formatTime(long time, int n, Boolean isOutfile) {
        String out;
        if (isOutfile) {
            out = "%d, %d\n".formatted(n, time);
        } else {
            out = "%d:\t%dns\n".formatted(n, time);
        }

        return out;
    }

    private static void writeTime(StringBuilder out, Boolean isOutfile, String outfile) {
        if (!isOutfile) {
            System.out.println(out);
            return;
        }

        try{
            BufferedWriter writer = new BufferedWriter(new FileWriter(outfile));
            writer.append(out);
            writer.close();

        } catch (IOException e) {
            throw new RuntimeException(e);
        }
    }
}