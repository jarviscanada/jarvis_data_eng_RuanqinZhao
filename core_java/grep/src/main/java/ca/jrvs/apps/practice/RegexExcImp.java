package ca.jrvs.apps.practice;

import ca.jrvs.apps.practice.RegexExc;

import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class RegexExcImp implements RegexExc {

    /**
     * return true if filename extension is jpg or jpeg (case insensitive)
     *
     * @param filename
     * @return
     */
    public boolean matchJpeg(String filename) {
        String regexFilename = "\\w+\\.jp(g|eg)";
        Pattern pat = Pattern.compile(regexFilename, Pattern.CASE_INSENSITIVE);
        Matcher mat = pat.matcher(filename);
        return mat.matches();
    }

    /**
     * return true if ip is valid
     * to simplify the problem, IP address range is from 0.0.0.0 to 999.999.999.999
     *
     * @param ip
     * @return
     */
    public boolean matchIp(String ip) {
        String regexIp = "(\\d{1,3}.){3}\\d{1,3}";
        Pattern pat = Pattern.compile(regexIp);
        Matcher mat = pat.matcher(ip);
        return mat.matches();
    }

    /**
     * return true if line is empty (e.g. empty, white space, tabs, etc...)
     *
     * @param line
     * @return
     */
    public boolean isEmptyLine(String line) {
        String regexEmpty = "[\\s]*";
        Pattern pat = Pattern.compile(regexEmpty);
        Matcher mat = pat.matcher(line);
        return mat.matches();
    }

}
