(hall-description
  (name "mutvis")
  (prefix "")
  (version "0.1")
  (author "mbc")
  (copyright (2022))
  (synopsis "")
  (description "")
  (home-page "www.labsolns.com")
  (license gpl3+)
  (dependencies `())
  (skip ())
  (files (libraries
           ((directory "mutvis" ()) (scheme-file "mutvis")))
         (tests ((directory "tests" ())))
         (programs ((directory "scripts" ())))
         (documentation
           ((text-file "AUTHORS")
            (text-file "NEWS")
            (directory "doc" ((texi-file "mutvis")))
            (text-file "COPYING")
            (text-file "HACKING")
            (symlink "README" "README.org")
            (org-file "README")))
         (infrastructure
           ((scheme-file "hall")
            (text-file ".gitignore")
            (scheme-file "guix")))))