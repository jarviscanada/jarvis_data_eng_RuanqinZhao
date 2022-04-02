package ca.jrvs.apps.practice;

class HelloWorld{
    public static void main(String[] args) {
        System.out.println("Hello, World");
        ca.jrvs.apps.practice.RegexExcImp r = new ca.jrvs.apps.practice.RegexExcImp();
        System.out.println("1:" + r.matchJpeg("a12.JPEG"));
        System.out.println("2:" + r.matchIp("12.234.9.999"));
        System.out.println("3:" + r.isEmptyLine(""));


    }
}