package jandcode.demos.web.empty.action;

import jandcode.web.*;
import org.joda.time.*;

import java.util.*;

public class HelloAction extends WebAction {

    public void world() throws Exception {
        Map data = new HashMap();
        data.put("time", new DateTime());
        render("hello/world.gsp", "data", data);
    }


}
