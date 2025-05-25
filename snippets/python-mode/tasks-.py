# -*- mode: snippet -*-
# name: tasks-
# key: tasks-
# expand-env: ((yas/indent-line 'fixed) (yas/wrap-around-region 'nil))
# --
import os, sys, subprocess
import invoke

# ========================================================= #
# ===  build command                                    === #
# ========================================================= #
@invoke.task( help={ 'file': 'input file == input file.'} )
def build( c, file="${1:src}" ):
    """ build command -- invoke build --file=src etc. """
    # ------------------------------------------------- #
    # --- [1] file check                            --- #
    # ------------------------------------------------- #
    if not( os.path.exists(file) ):
        sys.exit(" cannot find input file :: {}".format( file ))
    else:
        print( f"\n --- input : {file} --- \n" )
    # ------------------------------------------------- #
    # --- [2] build command                       --- #
    # ------------------------------------------------- #
    build__cmd = "${2:command} {}".format( file )
    try:
        subprocess.run( build__cmd, shell=True, check=True )
        print(  "\n ---      End       --- \n" )
    except Exception as e:
        print( f"Error :: {e}" )
    return()
        

# ========================================================= #
# ===  run command                                      === #
# ========================================================= #
@invoke.task
def run(c):
    """ run command -- invoke run """
    # ------------------------------------------------- #
    # --- [1] execute command                       --- #
    # ------------------------------------------------- #
    cmd = "${3:go}"
    try:
        subprocess.run( cmd, shell=True, check=True )
    except Exception as e:
        print( f"Error :: {e}" )
    return()
        

# ========================================================= #
# ===  post command                                     === #
# ========================================================= #
@invoke.task
def post(c):
    """ post command -- invoke post """
    # ------------------------------------------------- #
    # --- [1] execute command                       --- #
    # ------------------------------------------------- #
    cmd = "${4:post}"
    try:
        subprocess.run( cmd, shell=True, check=True )
    except Exception as e:
        print( f"Error :: {e}" )
    return()


# ========================================================= #
# ===  clean command                                    === #
# ========================================================= #
@invoke.task
def clean(c):
    """ clean command -- invoke clean """
    extensions = [ "${5:.out}" ]
    deleted    = 0
    for file in os.listdir("."):
        if any( file.endswith( ext ) for ext in extensions ):
            os.remove(file)
            deleted += 1
    print(f" --- delete : {deleted} files --- " )
    return()

$0