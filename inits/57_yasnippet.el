(add-to-list 'load-path
	     "~/.emacs.d/elpa/yasnippet-20180916.2115")
(require 'yasnippet)
(setq yas-snippet-dirs '("~/.emacs.d/mysnippets"
			 "~/.emacs.d/snippets" ))
(yas-global-mode 1)
