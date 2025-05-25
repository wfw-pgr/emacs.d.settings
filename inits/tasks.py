import os, invoke, subprocess

# [How To]
# invoke build
#
# [What is done ]
# $ emacs --batch --eval "(progn (add-to-list 'load-path \"~/.emacs.d/modes\") (add-to-list 'load-path \"~/.emacs.d/lisps/yasnippet\"))" --eval "(byte-recompile-directory \"~/.emacs.d/inits\" 0)"
#

# ========================================================= #
# ===  build command for emacs-lisp   .el => .elc       === #
# ========================================================= #
@invoke.task
def build( ctx ):
    
    emacs_cmd = (
        'emacs --batch '
        '--eval "(progn '
        '(add-to-list \'load-path \\\"~/.emacs.d/modes\\\") '
        '(add-to-list \'load-path \\\"~/.emacs.d/lisps/yasnippet\\\"))" '
        '--eval "(byte-recompile-directory \\\"~/.emacs.d/inits\\\" 0)"'
    )

    print( "[Building] .elc files .... ", end="" )
    result = subprocess.run( emacs_cmd, shell=True )
    print( "     [Done]" )

    
# ========================================================= #
# === clean command                                     === #
# ========================================================= #
@invoke.task
def clean( ctx ):
    
    cmd = "rm ./*.elc"
    print( cmd )
    subprocess.run( cmd, shell=True )
