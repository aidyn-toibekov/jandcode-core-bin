<% diag_doc = {diagram ->
  def dotfile = "images\\${diagram.name}__diag_doc.dot"
%>

<h2 class="table_desc"><a name="${diagram.name}__diag_doc"></a>${diagram.title}</h2>
<%
    def comment = diagram.comment.trim()
    if (comment != "") {
      out("<p>\n")
      out(comment)
      out("</p>\n")
    }
%>
<img src="images/${diagram.name}__diag_doc.png" usemap="#${diagram.name}__diag_doc__map"/>
<%
    pushFile(dotfile)
    def dup = [:]
%>
digraph ${diagram.name}__diag_doc__map {
  edge[fontname="Arial" fontsize="8"]
<%
    for (di in diagram.items) {
      def t = di.domain
      out("""${t.name}[shape=none fontname="Arial" fontsize="8" URL="#${t.name}" label=<<table align="center" border="0" cellborder="1" cellspacing="0">
<tr><td><b>${t.name}</b></td></tr>
""")
      if (di.showFields) {
        out("""
<tr><td>
<table border="0" cellborder="0" cellspacing="0">
""")
        for (f in th.fields(t)) {
          def ref_color = "black"
          def dt = get_fieldtype(f)
          if (f.hasRef()) {
            if (diagram.domains.find(f.refName) == null) {
              ref_color = "red" // ссылки на диаграмме нет
            } else {
              ref_color = "blue"
            }
          }
          out("""<tr><td align="left">""")
          out("""${f.name}: ${dt}""");
          if (f.hasRef()) {
            out("""<i><font color="${ref_color}"> #</font></i>""");
          }
          out("""</td></tr>\n""")
        }
        out("</table></td></tr>")
      }
      out("""</table>>]\n""")

      // refs
      for (r in diagram.domains.getRefsFrom(t.name)) {
        def key = r.src.name + "->" + r.dest.name + " [label=\"${r.ref.name}\"];\n";
        if (key in dup) continue;
        dup[key] = 1
        out(key)
      }

      for (r in diagram.domains.getRefsTo(t.name)) {
        def key = r.src.name + "->" + r.dest.name + " [label=\"${r.ref.name}\"];\n";
        if (key in dup) continue;
        dup[key] = 1
        out(key)
      }

    }
%>

}
<%
      popFile()
      def a = ut.runexe(cmd: "dot ${outdir}\\${dotfile} -Tcmapx", saveout: true, showout: false)
      out(a.join())
    }
%>
