//
project.name = '${project.name}-product'
//
<% for (f in ut.filelist("*-product.jc", wd("temp/distr/web/WEB-INF/scripts"))) { %>
include "${fu.filename(f)}"
<% } %>
//
if (fu.exists(wd("_project.jc"))) include wd("_project.jc")
//
