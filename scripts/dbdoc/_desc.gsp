<%@ page import="jandcode.dbm.*" %>
<% desc = {Domain t ->
  // на каких диаграммах используется
  def domainDiagrams = diagrams.getDiagrams(t.name)
  def flds = th.fields(t)
  def dd = th.dbtable(t)
%>
<h2 class="table-desc"><a name="${t.name}"></a>${t.name}
<% if (dd.view) { %>
  <i>(view)</i>
  <% } %>
</h2>
${t.title}
<% out_comment(t) %>

<% if (dd.view) { %>
<h3>DDL</h3>
<pre><% th.domain = t; outTemplate(dd.getDdl("view")) %></pre>
<% } %>

<% if (domainDiagrams.size() > 0) { %>
<h3>Используется в диаграммах</h3>
<ul>
  <% for (diag in domainDiagrams) { %>
  <li><a href="#${diag.name}__diag_doc">${diag.title}</a></li>
  <% } %>
</ul>
<% } %>

<h3>Поля</h3>
<table class="table-fields">
  <tr>
    <th>Поле</th>
    <th>Тип</th>
    <th>Ограничения</th>
    <th>Описание</th>
  </tr>
  <% for (f in flds) { %>
  <tr>
    <td>${f.name}</td>
    <td><%
        if (!f.hasRef()) {
          out(get_fieldtype(f))
        } else {
          out("""<a href="#${f.refName}">${get_fieldtype(f)}</a>""")
        }
    %></td>
    <td>
      <%
          def constr = []
          if (f.req) constr.add("req")
          if (f.notNull) constr.add("notNull")
          //todo добавить валидаторы
          if (constr.size() == 0) {
            out("&nbsp;")
          } else {
            out(constr.join(", "))
          }
      %>
    </td>
    <td>${f.title}
    <% out_comment(f) %>
    </td>
  </tr>
  <% } %>
</table>

<h3>Диаграмма ссылок</h3>
<img src="images/${t.name}__diag_ref.png" usemap="#${t.name}__diag_ref"/>
<% } %>