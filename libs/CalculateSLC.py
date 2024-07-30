from numpy import array

def Goelzer_SLC(iVAbove: array, bBSL: array, iVAll: array) -> array:

    '''
    Calculates sea level contribution from variables provided by the 
    BISICLES GIAstats filetool. Follows Goelzer et al. (2020) 
    https://doi.org/10.5194/tc-14-833-2020

    inputs: 
        - iVAbove: ice Volume Above (Floatation)
        - bBSL: bedrock Below Sea Level
        - iVAll: ice Volume All
    returns: 
        - SLC: Sea level contribution
    '''
    
    A_ocean = 3.625e14  # surface area of the ocean in m^-2 (Gregory et al., 2019)
    rho_ocean = 1028    # density of seawater (kg m^-3)
    rho_ice = 918       # density of ice (kg m^-3)

    # baseline values to calculate differences
    iVAbove_init = iVAbove[0]
    bBSL_init = bBSL[0]
    iVAll_init = iVAll[0]

    SLC_vaf = -(iVAbove - iVAbove_init) * rho_ice / (rho_ocean * A_ocean)
    SLC_pov = -(bBSL - bBSL_init) / A_ocean
    SLC_den = -(iVAll - iVAll_init) * (rho_ice/1000 - rho_ice/rho_ocean) / A_ocean

    return SLC_vaf, SLC_pov, SLC_den