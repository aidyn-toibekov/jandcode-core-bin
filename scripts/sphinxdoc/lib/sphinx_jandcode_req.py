# -*- coding: utf-8 -*-
"""
    sphinx_jandcode_req
    ~~~~~~~~~~~~~~~~~~~

    Вводит тег '.. req::' - одиночное требование к системе.
    Пока без наворотов.

    Сделано из sphinx.ext.todo путем простого переименования todo на req.


"""

from docutils import nodes

from sphinx.locale import _
from sphinx.environment import NoUri
from sphinx.util.nodes import set_source_info
from sphinx.util.compat import Directive, make_admonition

class req_node(nodes.Admonition, nodes.Element): pass


class reqlist(nodes.General, nodes.Element): pass


class Req(Directive):
    """
    """

    has_content = True
    required_arguments = 0
    optional_arguments = 0
    final_argument_whitespace = False
    option_spec = {}

    def run(self):
        env = self.state.document.settings.env
        targetid = 'index-%s' % env.new_serialno('index')
        targetnode = nodes.target('', '', ids=[targetid])

        ad = make_admonition(req_node, self.name, [_('Req')], self.options,
            self.content, self.lineno, self.content_offset,
            self.block_text, self.state, self.state_machine)
        set_source_info(self, ad[0])
        return [targetnode] + ad


def process_reqs(app, doctree):
    # collect all reqs in the environment
    # this is not done in the directive itself because it some transformations
    # must have already been run, e.g. substitutions
    env = app.builder.env
    if not hasattr(env, 'req_all_reqs'):
        env.req_all_reqs = []
    for node in doctree.traverse(req_node):
        try:
            targetnode = node.parent[node.parent.index(node) - 1]
            if not isinstance(targetnode, nodes.target):
                raise IndexError
        except IndexError:
            targetnode = None
        env.req_all_reqs.append({
            'docname': env.docname,
            'source': node.source or env.doc2path(env.docname),
            'lineno': node.line,
            'req': node.deepcopy(),
            'target': targetnode,
            })


class ReqList(Directive):
    """
    A list of all req entries.
    """

    has_content = False
    required_arguments = 0
    optional_arguments = 0
    final_argument_whitespace = False
    option_spec = {}

    def run(self):
        # Simply insert an empty reqlist node which will be replaced later
        # when process_req_nodes is called
        return [reqlist('')]


def process_req_nodes(app, doctree, fromdocname):
    # Replace all reqlist nodes with a list of the collected reqs.
    # Augment each req with a backlink to the original location.
    env = app.builder.env

    if not hasattr(env, 'req_all_reqs'):
        env.req_all_reqs = []

    for node in doctree.traverse(reqlist):
        content = []

        for req_info in env.req_all_reqs:
            para = nodes.paragraph(classes=['req-source'])
            description = _('(The <<original entry>> is located in '
                            ' %s, line %d.)') %\
                          (req_info['source'], req_info['lineno'])
            desc1 = description[:description.find('<<')]
            desc2 = description[description.find('>>') + 2:]
            para += nodes.Text(desc1, desc1)

            # Create a reference
            newnode = nodes.reference('', '', internal=True)
            innernode = nodes.emphasis(_('original entry'), _('original entry'))
            try:
                newnode['refuri'] = app.builder.get_relative_uri(
                    fromdocname, req_info['docname'])
                newnode['refuri'] += '#' + req_info['target']['refid']
            except NoUri:
                # ignore if no URI can be determined, e.g. for LaTeX output
                pass
            newnode.append(innernode)
            para += newnode
            para += nodes.Text(desc2, desc2)

            # (Recursively) resolve references in the req content
            req_entry = req_info['req']
            env.resolve_references(req_entry, req_info['docname'],
                app.builder)

            # Insert into the reqlist
            content.append(req_entry)
            content.append(para)

        node.replace_self(content)


def purge_reqs(app, env, docname):
    if not hasattr(env, 'req_all_reqs'):
        return
    env.req_all_reqs = [req for req in env.req_all_reqs
                        if req['docname'] != docname]


def visit_req_node(self, node):
    self.visit_admonition(node)


def depart_req_node(self, node):
    self.depart_admonition(node)


def setup(app):
    app.add_node(reqlist)
    app.add_node(req_node,
        html=(visit_req_node, depart_req_node),
        latex=(visit_req_node, depart_req_node),
        text=(visit_req_node, depart_req_node),
        man=(visit_req_node, depart_req_node),
        texinfo=(visit_req_node, depart_req_node))

    app.add_directive('req', Req)
    app.add_directive('reqlist', ReqList)
    app.connect('doctree-read', process_reqs)
    app.connect('doctree-resolved', process_req_nodes)
    app.connect('env-purge-doc', purge_reqs)

