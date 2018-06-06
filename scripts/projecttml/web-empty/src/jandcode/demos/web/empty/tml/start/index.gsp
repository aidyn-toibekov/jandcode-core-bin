<jc:page tml="main">

  <h1>Welcome!</h1>

  This is start page

  <ul>
    <li><a href="${ref("hello/world")}">Hello world (from action)</a></li>
    <li><a href="${ref("tml/hello/world.html")}">Hello world (from gsp template)</a></li>
    <li><a href="${ref("tst")}">Тесты</a></li>
  </ul>

</jc:page>