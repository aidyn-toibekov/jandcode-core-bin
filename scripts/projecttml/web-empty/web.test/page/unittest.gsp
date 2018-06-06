<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
  <title>Тест: ${request.pathInfo}</title>

  <% include("/page/header.gsp") %>

  <jc:linkJs url="js/jsunittest/jsunittest.js"/>
  <jc:linkCss url="js/jsunittest/jsunittest.css"/>

  ${args.headertext}

</head>

<body>
<!-- Log output (one per Runner, via {testLog: "testlog"} option)-->
<div id="testlog"></div>

${args.bodytext}
</body>
</html>
