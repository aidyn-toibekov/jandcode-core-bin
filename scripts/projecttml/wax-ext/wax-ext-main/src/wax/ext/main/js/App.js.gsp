<%@ page import="jandcode.lang.*" %>
<script type="text/javascript">
  Ext.define("Jc.App", {
    extend: "Jc.BaseApp",

    createMainMenu: function() {
      //
      var menu = Jc.menu;
      var item = Jc.action;
      //
      var logo = Ext.create('Jc.control.PageHeader', {
        text: Jc.ini.app.title,
        icon: Jc.url("page/logo-small.png"),
        width: 260,
        listeners: {
          click: {
            element: 'el',
            fn: function() {
              Jc.app.home();
            }
          }
        }
      });
      //
      return [logo, '-'].concat(this.createMenuForUser());
    },

    createMenuForUser: function() {
      var mm = [
        Jc.action({text: 'Home', icon: 'home', scope: this, onExec: this.home}),
        '->'
      ];
      return mm;
    },

    home: function() {
      Jc.showFrame({frame: "Jc.Home", id: true});
    },

    //

    __end__: null

  });
</script>
