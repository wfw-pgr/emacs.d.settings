import numpy as np

# ========================================================= #
# ===  make__af.py ( for superfish )                    === #
# ========================================================= #

def make__af():

    # ------------------------------------------------- #
    # --- [1] load parameters                       --- #
    # ------------------------------------------------- #

    import nkUtilities.load__constants as lcn
    cnfFile = "dat/parameter.conf"
    const = lcn.load__constants( inpFile=cnfFile )


    print()
    print( "[make__af.py] outFile :: {0} ".format( const["outFile"] ) )
    print()

    # ------------------------------------------------- #
    # --- [2] calculation of length                 --- #
    # ------------------------------------------------- #

    #  -- [2-1] calculate physical length           --  #
    wavelength = const["cv"] / const["frequency"] * const["beta"]

    if ( const["auto_cell_Diameter"] ):
        Dp     = const["r1_bessel"] / np.pi * wavelength   # -- pillbox length -- #
        Dp     = Dp - const["r_neck"] - const["r_beam_pipe"]
    else:
        Dp     = const["cell_Diameter"]

    if ( const["auto_cell_Length"] ):
        Lp     = const["auto_cell_Lenfactor"] * wavelength
    else:
        Lp     = const["cell_Length"]

    #  -- [2-2] load constants                      --  #
    unit_mm    = 1.e-3
    Dp         =       Dp / unit_mm
    Lp         =       Lp / unit_mm
    Dn         = const["r_neck"]      / unit_mm
    Ln         = const["L_neck"]      / unit_mm
    rpipe      = const["r_beam_pipe"] / unit_mm
    Lpipe      = const["L_beam_pipe"] / unit_mm
    rr         = const["r_round"]     / unit_mm
    hLp_hLn    = 0.5*( Lp - Ln )
    
    #  -- [2-3] calculate coordinate                --  #
    z1         =     Lpipe
    z2         =     Lpipe + hLp_hLn
    z3         =     Lpipe + hLp_hLn + Ln
    z4         =     Lpipe + Lp
    z5         = 2.0*Lpipe + Lp
    
    r1         = rpipe
    r2         = rpipe + Dn
    r3         = rpipe + Dn + Dp

    print()
    print( "[make__af.py]   Lp  :: {0} ".format( Lp ) )
    print( "[make__af.py]   Dp  :: {0} ".format( Dp ) )
    print()
    
    # ------------------------------------------------- #
    # --- [3] comment & settings                    --- #
    # ------------------------------------------------- #

    if ( const["auto_drive_point"] ):
        z23               = 0.5*( z2+z3 )
        const["xy_drive"] = [ z23, r3 ]
    
    comment = \
        "### {0} GHz Cavity\n"\
        "### disk-loaded cavity \n"\
        "### created by K.Nishida\n"\
        "###\n\n".format( const["frequency"]/1.0e9 )

    generals = \
        "kprob=1                                ! superfish problem \n"\
        "icylin=1                               ! cylindrical coordinates \n"\
        "conv={0}                               ! unit conversion ( e.g. cm => mm ) \n"\
        "freq={1}                               ! frequency (MHz) \n"\
        "dx={2}                                 ! mesh size \n"\
        "xdri={3[0]},ydri={3[1]}                ! drive point of RF \n"\
        "kmethod=1                              ! use beta to compute wave number \n"\
        "beta={4}                               ! Particle velocity for transit-time integrals \n"\
        .format( const["unit_conversion"], const["frequency"]/1.0e6, const["meshsize"], \
                 const["xy_drive"], const["beta"] )

    boundaries = \
        "nbsup={0}                              ! boundary :: upper  ( 0:Neumann, 1:Dirichlet )\n"\
        "nbslo={1}                              !          :: lower  \n"\
        "nbsrt={2}                              !          :: right  \n"\
        "nbslf={3}                              !          :: left   \n"\
        .format( const["boundary_upper"], const["boundary_lower"], \
                 const["boundary_right"], const["boundary_left"] )
        
    
    settings   = "&reg {0}{1}&\n\n".format( generals, boundaries )

    # ------------------------------------------------- #
    # --- [4] po points to be connected             --- #
    # ------------------------------------------------- #
    
    # -- ltype_== 1 :: straight line.
    # -- ltype_== 2 :: circle.
    # -- ltype_, x_, y_, x0_, y0_ -- #
    #
    if ( const["sw_round"] ):
        pts        = [ [ 1,           0.0,         0.0,      0.0,    0.0 ],
                       [ 1,           0.0,          r1,      0.0,    0.0 ],
                       [ 1,         z2-rr,          r1,      0.0,    0.0 ],
                       [ 2,           0.0,         +rr,    z2-rr,  r1+rr ],
                       [ 1,         z1+rr,          r2,      0.0,    0.0 ],
                       [ 2,           -rr,         0.0,    z1+rr,  r2+rr ],
                       [ 1,            z1,       r3-rr,      0.0,    0.0 ],
                       [ 2,           0.0,         +rr,    z1+rr,  r3-rr ],
                       [ 1,         z4-rr,          r3,      0.0,    0.0 ],
                       [ 2,           +rr,         0.0,    z4-rr,  r3-rr ],
                       [ 1,            z4,       r2+rr,      0.0,    0.0 ],
                       [ 2,           0.0,         -rr,    z4-rr,  r2+rr ],
                       [ 1,         z3+rr,          r2,      0.0,    0.0 ],
                       [ 2,           0.0,         -rr,    z3+rr,  r1+rr ],
                       [ 1,            z5,          r1,      0.0,    0.0 ],
                       [ 1,            z5,         0.0,      0.0,    0.0 ],
                       [ 1,           0.0,         0.0,      0.0,    0.0 ]
        ]
    else:
        pts        = [ [ 1,           0.0,         0.0,      0.0,  0.0 ],
                       [ 1,           0.0,          r1,      0.0,  0.0 ],
                       [ 1,            z2,          r1,      0.0,  0.0 ],
                       [ 1,            z2,          r2,      0.0,  0.0 ],
                       [ 1,            z1,          r2,      0.0,  0.0 ],
                       [ 1,            z1,          r3,      0.0,  0.0 ],
                       [ 1,            z4,          r3,      0.0,  0.0 ],
                       [ 1,            z4,          r2,      0.0,  0.0 ],
                       [ 1,            z3,          r2,      0.0,  0.0 ],
                       [ 1,            z3,          r1,      0.0,  0.0 ],
                       [ 1,            z5,          r1,      0.0,  0.0 ],
                       [ 1,            z5,         0.0,      0.0,  0.0 ],
                       [ 1,           0.0,         0.0,      0.0,  0.0 ]
        ]
        
    pts        = np.array( pts )

    ltype_, x_, y_, x0_, y0_  = 0, 1, 2, 3, 4
    geometry   = ""
    for ik, pt in enumerate( pts ):
        if ( int( pt[ltype_] ) == 1 ):
            geometry += "$po x={0}, y={1} $\n".format( pt[x_], pt[y_] )
        if ( int( pt[ltype_] ) == 2 ):
            geometry += "$po nt=2, x={0}, y={1}, x0={2}, y0={3} $\n"\
                .format( pt[x_], pt[y_], pt[x0_], pt[y0_] )
        
    # ------------------------------------------------- #
    # --- [4] write in a file                       --- #
    # ------------------------------------------------- #

    with open( const["outFile"], "w" ) as f:
        f.write( comment  )
        f.write( settings )
        f.write( geometry )
    return()


# ========================================================= #
# ===   実行部                                          === #
# ========================================================= #

if ( __name__=="__main__" ):
    make__af()
