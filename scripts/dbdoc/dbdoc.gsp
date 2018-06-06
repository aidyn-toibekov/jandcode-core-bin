<%--
  Генерация документации html по базе данных
--%>
<html>
<%
  //
  include "scripts/dbdoc/_utils.gsp"
  include "scripts/dbdoc/_desc.gsp"
  include "scripts/dbdoc/_diag_ref.gsp"
  include "scripts/dbdoc/_diag_doc.gsp"
  //
  def tdir = repo.getFile("scripts/dbdoc")
  ant.copy(todir: outdir) {
    fileset(dir: tdir) {
      include(name: "**/*")
      exclude(name: "**/*.gsp")
    }
  }

%>
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
  <title>Документация по базе данных</title>
  <link rel="stylesheet" href="style.css"/>
</head>

<body>
<h1><a name="_top"></a>Документация по базе данных</h1>

<h2>Содержание</h2>
<ul>
  <li><a href="#__toc_diag_doc">Диаграммы</a></li>
  <li><a href="#__toc_tab">Таблицы</a></li>
  <li><a href="#__toc_nodiag">Таблицы не показанные на диаграммах</a></li>
</ul>

<h2><a name="__toc_diag_doc"></a>Диаграммы</h2>
<ul>
  <% for (diagram in diagrams.diagrams) { %>
  <li><a href="#${diagram.name}__diag_doc">${diagram.title}</a></li>
  <% } %>
</ul>

<h2><a name="__toc_tab"></a>Таблицы</h2>
Всего таблиц: <b>${th.tables().size()}</b>
<ul>
  <%
    for (t in th.tables()) {
      dd = th.dbtable(t)
  %>
  <li><a href="#${t.name}">${t.name}</a> <font size="-2">
    <% if (dd.view) { %>
    <i><b>(view)</b></i>
    <% } %>
    <i>${t.title}</i>
  </font></li>
  <% } %>
</ul>

<h2><a name="__toc_nodiag"></a>Таблицы не показанные на диаграммах</h2>
<ul>
  <%
    def nodiagCount = 0
    for (t in th.tables()) {
      def domainDiagrams = diagrams.getDiagrams(t.name)
      if (domainDiagrams.size() > 0) continue;
      nodiagCount++
  %>
  <li><a href="#${t.name}">${t.name}</a></li>
  <% } %>
</ul>

<%
  // диаграммы
  for (diagram in diagrams.diagrams) {
    diag_doc(diagram)
  }
  // таблицы
  for (t in th.tables()) {
    desc(t)
    diag_ref(t)
  }
%>

</body>
</html>