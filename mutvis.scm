(define-module (labsolns mutvis)
 #:use-module  (guix packages)
  #:use-module ((guix licenses) #:prefix license:)
  #:use-module (guix download)
  #:use-module (guix git-download)
  #:use-module (guix build-system gnu)
  #:use-module (gnu packages)
  #:use-module (gnu packages statistics)
  #:use-module (gnu packages cran))

(define-public mutvis
(package
  (name "mutvis")
  (version "0.1")
(source (origin
                (method git-fetch)
                (uri (git-reference
                      (url "git://github.com/mbcladwell/mutvis.git")
                      (commit "9b53c7998130df09de9bfa25bd90a93749dfff70")))
                (sha256 (base32 "1jzwjk3ni58nzijl21ja4z62lxbx7y7jqa5r5b6w9vc4d92pbg5j"))
		))

  (build-system gnu-build-system)
  (arguments `(	#:phases (modify-phases %standard-phases
					(add-after 'unpack 'patch-prefix
						   (lambda* (#:key inputs outputs #:allow-other-keys)
						     (substitute* '("./mutvis.sh"
								    "./mutvis2.sh"
								    "./app.R")
								  (("abcdefgh")
								   (assoc-ref outputs "out" )) )
						     #t))
					(add-before 'install 'copy-app
						    (lambda* (#:key outputs #:allow-other-keys)
						      (let* ((out  (assoc-ref outputs "out")))
							     (install-file "app.R" out)     			     	     
							     #t)))
					(add-before 'install 'copy-executable
						    (lambda* (#:key outputs #:allow-other-keys)
						      (let* ((out  (assoc-ref outputs "out"))
							     (bin-dir (string-append out "/bin"))
	    						    (install-file "./mutvis.sh" bin-dir)
							     )            				       
							(install-file "./mutvis2.sh" bin-dir)
							#t)))
				(add-before 'install 'copy-seqs
						    (lambda* (#:key outputs #:allow-other-keys)
						      (let* ((out  (assoc-ref outputs "out"))
							     )            				       
							(install-file "./input.aln" out)
							#t)))
					(add-after 'install 'wrap-seqeval
						   (lambda* (#:key inputs outputs #:allow-other-keys)
						     (let* ((out (assoc-ref outputs "out"))
							    (bin-dir (string-append out "/bin"))					   
							    (dummy (chmod (string-append out "/bin/mutvis.sh") #o555 )) ;;read execute, no write
							    (dummy (chmod (string-append out "/bin/mutvis2.sh") #o555 ))
							    (dummy (wrap-program (string-append out "/bin/mutvis.sh")
								     `( "PATH" ":" prefix  (,bin-dir) )))
							    ) 
						       (wrap-program (string-append out "/bin/mutvis2.sh")
								     `( "PATH" ":" prefix  (,bin-dir) ))
						       #t)))					
	      ) ))
  (native-inputs
    `(
   ; ("autoconf" ,autoconf)
    ;  ("automake" ,automake)
     ; ("pkg-config" ,pkg-config)
      ;("texinfo" ,texinfo)
      ))
  (inputs `(
	    ("r-seqinr" ,r-seqinr)
	    ("r-shiny" ,r-shiny)))
  (propagated-inputs `(
		       ("r" ,r)
		       ))
  (synopsis "")
  (description "")
  (home-page "www.labsolns.com")
  (license license:gpl3+)))

mutvis
