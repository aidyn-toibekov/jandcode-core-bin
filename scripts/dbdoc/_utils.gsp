<%@ page import="jandcode.dbm.doc.*; jandcode.dbm.db.*; jandcode.utils.rt.*; jandcode.dbm.*; jandcode.app.*; jandcode.utils.*" %>
<%

  /**
   * Утилиты модели
   */
  th = new DbModelExt(db.model)

  /**
   * Диаграммы модели
   */
  diagrams = new DiagramModelExt(db.model)

  /**
   * Вывод коментария из узла rt, привязанного к объекту o
   */
  out_comment = {CompRt o ->
    def rem = o.rt.getValueString(Rt.COMMENT)
    if (rem != "") {
      def t = new XText2Html()
      t.load().fromString(rem)
      out("<div class=\"comment\">" + t.result + "</div>")
    }
  }

  /**
   * тип поля для показа в тексте
   */
  get_fieldtype = {Field f ->
    def dt = f.getDbDataType()
    if (f.size > 0) {
      dt = dt + "(${f.size})"
    }
    if (f.hasRef()) {
      def r1 = f.refName
      dt = "ref(" + r1 + ")"
    }
    return dt
  }

%>