class latex {

  package { ["texlive",
             "texlive-xetex",
             "texlive-latex-extra",
             "texlive-lang-french"]:
    ensure => installed }

}
