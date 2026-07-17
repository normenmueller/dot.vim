call nemprofile#configure_nerdtree()
call nemprofile#configure_lightline('one')

let g:tglthm_profiles = nemprofile#theme_pair('onehalfdark', 'onehalflight')
let g:tglthm_profiles.dark.lightline = 'one'
let g:tglthm_profiles.light.lightline = 'one'
