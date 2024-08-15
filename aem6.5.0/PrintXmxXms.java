//https://www.baeldung.com/ops/docker-jvm-heap-size
import java.lang.management.MemoryMXBean;
import java.lang.management.ManagementFactory;
import java.util.logging.Level;
import java.util.logging.Logger;

public class PrintXmxXms {
  public static void main(String[] args) {
    int mb = 1024 * 1024;
    MemoryMXBean memoryBean = ManagementFactory.getMemoryMXBean();
    long xmx = memoryBean.getHeapMemoryUsage().getMax() / mb;
    long xms = memoryBean.getHeapMemoryUsage().getInit() / mb;
    Logger LOGGER = Logger.getLogger("LoggingSample");
    LOGGER.log(Level.INFO, "Initial Memory (xms) : {0}mb", xms);
    LOGGER.log(Level.INFO, "Max Memory (xmx) : {0}mb", xmx);
  }
}

//alias java='/usr/lib/jvm/jdk-11/bin/java'; export JAVA_HOME=/usr/lib/jvm/jdk-11
//javac ./PrintXmxXms.java && java -cp ./ PrintXmxXms

