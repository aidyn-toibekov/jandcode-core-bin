<%@ page import="jandcode.dbm.*" %>
<%--
  Диаграмма ссылок
--%>
<% diag_ref = {Domain t ->
  def dotfile = "images/${t.name}__diag_ref.dot"
  pushFile(dotfile)
  def dup = [:]

%>
digraph ${t.name}__diag_ref {
  node [shape=box,fontname = "Tahoma",fontsize = 8];
  edge [fontname = "Tahoma",fontsize = 8, penwidth = 1];

${t.name} [shape=box,style=filled,URL="#${t.name}"];
<%

    for (r in th.tables().getRefsFrom(t.name)) {
      def key = r.src.name + "->" + r.dest.name + " [label=\"${r.ref.name}\"];\n";
      if (key in dup) continue;
      dup[key] = 1
      out(key)
      out("""${r.dest.name} [URL="#${r.dest.name}"];\n""")
    }

    for (r in th.tables().getRefsTo(t.name)) {
      def key = r.src.name + "->" + r.dest.name + " [label=\"${r.ref.name}\"];\n";
      if (key in dup) continue;
      dup[key] = 1
      out(key)
      out("""${r.src.name} [URL="#${r.src.name}"];\n""")
    }

%>

}
<%
      popFile()
      def a = ut.runexe(cmd: "dot ${outdir}\\${dotfile} -Tcmapx", saveout: true, showout: false)
      out(a.join())
    }
%>