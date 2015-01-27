(TeX-add-style-hook
 "rendu1"
 (lambda ()
   (TeX-add-to-alist 'LaTeX-provided-class-options
                     '(("article" "11pt")))
   (TeX-add-to-alist 'LaTeX-provided-package-options
                     '(("inputenc" "utf8") ("babel" "french") ("fontenc" "T1") ("ulem" "normalem") ("xcolor" "table") ("geometry" "a4paper" "margin=1cm" "bottom=3cm" "top=3cm")))
   (TeX-run-style-hooks
    "latex2e"
    "article"
    "art11"
    "inputenc"
    "babel"
    "fontenc"
    "fixltx2e"
    "graphicx"
    "longtable"
    "array"
    "float"
    "wrapfig"
    "rotating"
    "ulem"
    "amsmath"
    "textcomp"
    "marvosym"
    "wasysym"
    "amssymb"
    "hyperref"
    "xcolor"
    "geometry")
   (LaTeX-add-labels
    "sec:registres"
    "tab:méta-registres"
    "tab:status_register"
    "sec:memoire"
    "tab:memory-map")))

