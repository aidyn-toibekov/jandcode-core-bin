<%
  /*
  переменные:

  rtdoc - rt с документацией

   */

  def level_chars = ['#', '*', '=', '-', '^', '"', '~', '%']

%>
<%
  ///////////////////////////////////////////////////////////////////////////
  out_node = {x, level ->
    def s_doc = x.getValueString("comment")
    s_doc = su.normalizeIndent(s_doc)
    def type = x.getValueString("type")
%>

.. _rt//${x.path}:

<${x.name}>
${su.repeat(level_chars[level], 180)}

*Узел:* ``${x.path}`` <% if (type != "") { %>, *тип:* ``${type}``<% } %>

.. contents::
    :local:

${s_doc}

<%
      for (x1 in x.childs) {
        if (x1.name == "attr") {
          for (x2 in x1.getChilds()) {
            out_attr(x2, level + 1)
          }
        }
      }

      for (x1 in x.childs) {
        if (x1.name != "attr") {
          out_node(x1, level + 1)
        }
      }
    }

%>

<%
  ///////////////////////////////////////////////////////////////////////////
  out_attr = {x, level ->
    def s_doc = x.getValueString("comment")
    s_doc = su.normalizeIndent(s_doc)
    def type = x.getValueString("type")
    if (type == "") type = "string"
    def path = x.owner.owner.path
    def nm = x.name
%>

.. _rt//${path}//${nm}:

${nm}="${type}"
${su.repeat(level_chars[level], 180)}

*Атрибут:* ``${path}:${nm}``, *тип:* ``${type}``

${s_doc}


<% } %>

Rt конфигурация
@@@@@@@@@@@@@@@

.. contents::
    :local:

<%
  for (rx in rtdoc.childs) {
    out_node(rx, 0)
  }
%>