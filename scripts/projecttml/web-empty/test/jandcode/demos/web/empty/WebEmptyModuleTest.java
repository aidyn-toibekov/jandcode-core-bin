package jandcode.demos.web.empty;

import jandcode.app.test.*;
import org.junit.*;

public class WebEmptyModuleTest extends AppTestCase {

    {
        logSetUp = true;
    }

    @Test
    public void test1() throws Exception {
        app.saveAppRt();
    }


}
