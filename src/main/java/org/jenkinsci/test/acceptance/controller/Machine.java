package org.jenkinsci.test.acceptance.controller;

import java.io.Closeable;
import java.io.IOException;

/**
 * Represents a system accessible through SSH to run commands (like Jenkins masters and slaves.)
 *
 * @author Vivek Pandey
 * @author Kohsuke Kawaguchi
 */
public interface Machine extends Closeable {
    /**
     * Connects to this computer over SSH so that we can do stuff
     *
     * TODO: maybe consider using Overthere
     */
    Ssh connect();

    String getPublicIpAddress();

    String getUser();

    void terminate();

    /**
     * Client of {@link Machine} can use this directory and undearneath for whatever purpose.
     */
    String dir();

    /**
     * Allocates a TCP/IP port on the machine to be used by a test
     * (for example to let Jenkins listen on this port for HTTP.)
     */
    int getNextAvailablePort();

    /**
     * Convey the intention that this machine is no longer needed.
     * The implementation will releases this machine / recycle the machine, etc.
     *
     * Once this method is called, no other methods should be called.
     */
    void close() throws IOException;
}
