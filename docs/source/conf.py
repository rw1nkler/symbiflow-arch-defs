#!/usr/bin/env python3
# -*- coding: utf-8 -*-
#
# symbiflow-arch-defs documentation build configuration file, created by
# sphinx-quickstart on Thu Oct 18 14:29:14 2018.
#
# This file is execfile()d with the current directory set to its
# containing dir.
#
# Note that not all possible configuration values are present in this
# autogenerated file.
#
# All configuration values have a default; values that are commented out
# serve to show the default.

# If extensions (or modules to document with autodoc) are in another directory,
# add these directories to sys.path here. If the directory is relative to the
# documentation root, use os.path.abspath to make it absolute, like shown here.
#
import os
import sys
sys.path.insert(0, os.path.abspath('.'))

from collectors import ArchsCollector, ModelsCollector


# -- General configuration ------------------------------------------------

# If your documentation needs a minimal Sphinx version, state it here.
#
needs_sphinx = '3.0'

# Add any Sphinx extension module names here, as strings. They can be
# extensions coming with Sphinx (named 'sphinx.ext.*') or your custom
# ones.
extensions = [
    'sphinx.ext.autodoc',
    'sphinxcontrib.images',
    'symbolator_sphinx',
    'sphinxcontrib_hdl_diagrams'
]

# Add any paths that contain templates here, relative to this directory.
templates_path = ['_templates']

# The suffix(es) of source filenames.
# You can specify multiple suffix as a list of string:
#
# source_suffix = ['.rst', '.md']
source_suffix = '.rst'

# The master toctree document.
master_doc = 'index'

# General information about the project.
project = 'symbiflow-arch-defs'
copyright = '2018, Various'
author = 'Various'

# The version info for the project you're documenting, acts as replacement for
# |version| and |release|, also used in various other places throughout the
# built documents.
#
# The short X.Y version.
version = '0.1'
# The full version, including alpha/beta/rc tags.
release = '0.1'

# The language for content autogenerated by Sphinx. Refer to documentation
# for a list of supported languages.
#
# This is also used if you do content translation via gettext catalogs.
# Usually you set "language" from the command line for these cases.
language = None

# List of patterns, relative to source directory, that match files and
# directories to ignore when looking for source files.
# This patterns also effect to html_static_path and html_extra_path
exclude_patterns = []

# The name of the Pygments (syntax highlighting) style to use.
pygments_style = 'default'

# If true, `todo` and `todoList` produce output, else they produce nothing.
todo_include_todos = False

# -- Options for HTML output ----------------------------------------------

# The theme to use for HTML and HTML Help pages.  See the documentation for
# a list of builtin themes.
#
html_theme = 'sphinx_materialdesign_theme'

# Theme options are theme-specific and customize the look and feel of a theme
# further.  For a list of options available for each theme, see the
# documentation.
#
# html_theme_options = {}

# Add any paths that contain custom static files (such as style sheets) here,
# relative to this directory. They are copied after the builtin static files,
# so a file named "default.css" will overwrite the builtin "default.css".
# html_static_path = ['_static']

# Custom sidebar templates, must be a dictionary that maps document names
# to template names.
#
html_theme_options = {
    # Specify a list of menu in Header.
    # Tuples forms:
    #  ('Name', 'external url or path of pages in the document', boolean, 'icon name')
    #
    # Third argument:
    # True indicates an external link.
    # False indicates path of pages in the document.
    #
    # Fourth argument:
    # Specify the icon name.
    # For details see link.
    # https://material.io/icons/
    'header_links':
        [
            ('Home', 'index', False, 'home'),
            (
                "GitHub", "https://github.com/SymbiFlow/symbiflow-arch-defs",
                True, 'link'
            )
        ],

    # Customize css colors.
    # For details see link.
    # https://getmdl.io/customize/index.html
    #
    # Values: amber, blue, brown, cyan deep_orange, deep_purple, green, grey, indigo, light_blue,
    #         light_green, lime, orange, pink, purple, red, teal, yellow(Default: indigo)
    'primary_color': 'deep_purple',
    # Values: Same as primary_color. (Default: pink)
    'accent_color': 'purple',

    # Customize layout.
    # For details see link.
    # https://getmdl.io/components/index.html#layout-section
    'fixed_drawer': True,
    'fixed_header': True,
    'header_waterfall': True,
    'header_scroll': False,

    # Render title in header.
    # Values: True, False (Default: False)
    'show_header_title': False,
    # Render title in drawer.
    # Values: True, False (Default: True)
    'show_drawer_title': True,
    # Render footer.
    # Values: True, False (Default: True)
    'show_footer': True
}

# -- Options for HTMLHelp output ------------------------------------------

# Output file base name for HTML help builder.
htmlhelp_basename = 'symbiflow-arch-defsdoc'

# -- Options for LaTeX output ---------------------------------------------

latex_elements = {
    # The paper size ('letterpaper' or 'a4paper').
    #
    # 'papersize': 'letterpaper',

    # The font size ('10pt', '11pt' or '12pt').
    #
    # 'pointsize': '10pt',

    # Additional stuff for the LaTeX preamble.
    #
    # 'preamble': '',

    # Latex figure (float) alignment
    #
    # 'figure_align': 'htbp',
}

# Grouping the document tree into LaTeX files. List of tuples
# (source start file, target name, title,
#  author, documentclass [howto, manual, or own class]).
latex_documents = [
    (
        master_doc, 'symbiflow-arch-defs.tex',
        'symbiflow-arch-defs Documentation', 'Various', 'manual'
    ),
]

# -- Options for manual page output ---------------------------------------

# One entry per manual page. List of tuples
# (source start file, name, description, authors, manual section).
man_pages = [
    (
        master_doc, 'symbiflow-arch-defs', 'symbiflow-arch-defs Documentation',
        [author], 1
    )
]

# -- Options for Texinfo output -------------------------------------------

# Grouping the document tree into Texinfo files. List of tuples
# (source start file, target name, title, author,
#  dir menu entry, description, category)
texinfo_documents = [
    (
        master_doc, 'symbiflow-arch-defs', 'symbiflow-arch-defs Documentation',
        author, 'symbiflow-arch-defs', 'One line description of project.',
        'Miscellaneous'
    ),
]

hdl_diagram_yosys = "system"

# --- Generated Sources ------------------------------------------------------

repo_root = os.path.realpath("../../")

# The generated directory deletion has been added to the Makefile for local use
# On RTD server it is not necessary. Removing any directory from the config
# file result in a infinit loop of sphinx-livehtml
#
# import shutil
# shutil.rmtree("generated", ignore_error

mc = ModelsCollector(repo_root)
ac = ArchsCollector(repo_root)

prjxray_generatedir = os.path.realpath("generated/prjxray/models")
prjxray_search = ["xc/common/primitives"]
prjxray_skip_diagrams = ["alu"]
mc.generate_docs(prjxray_generatedir, prjxray_search, prjxray_skip_diagrams)

icestorm_model_generatedir = os.path.realpath("generated/ice40/models")
icestorm_arch_generatedir = os.path.realpath("generated/ice40/arch")
icestorm_search = ["ice40"]
icestorm_skip_diagrams = ["sb_pio"]
mc.generate_docs(icestorm_model_generatedir, icestorm_search, icestorm_skip_diagrams)
ac.generate_docs(icestorm_arch_generatedir, icestorm_search)

ecp5_generatedir = os.path.realpath("generated/ecp5/models")
ecp5_search = ["ecp5/primitives"]
ecp5_skip_diagrams = ["BB", "CCU2C", "OBZ", "TRELLIS_IO", "sb_pio"]
mc.generate_docs(ecp5_generatedir, ecp5_search, ecp5_skip_diagrams)
