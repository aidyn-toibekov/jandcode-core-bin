<%@ page import="jandcode.wax.core.utils.gf.*; jandcode.wax.core.utils.gf.*" %>
<jc:page tml="app">

  <gf:tstFrame>
  %{-- ========================================================================= --}%
    <gf:groovy>
      <%
        GfFrame gf = vars.gf
        GfAttrs a = gf.attrs
        //
      %>
    </gf:groovy>

  %{-- ========================================================================= --}%
    <g:javascript>
      th.title = 'Empty frame';
      th.items = [
        b.button({text: 'bbb1', onExec: function() {
          th.setTitle('sss');
        }})
      ];

      th.toolbar = [
        b.action({text: 'Action1', icon: 'show', onExec: function() {
          //
        }})
      ]

    </g:javascript>
  </gf:tstFrame>

</jc:page>