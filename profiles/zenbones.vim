call nemprofile#configure_lightline('zenbones')

let g:zenbones_compat = 1
let g:zenbones_darken_comments = 45

let g:tglthm_profiles = nemprofile#theme_pair('zenbones', 'zenbones')
let g:tglthm_profiles.dark.background = 'dark'
let g:tglthm_profiles.dark.lightline = 'zenbones'
let g:tglthm_profiles.light.background = 'light'
let g:tglthm_profiles.light.lightline = 'zenbones'
