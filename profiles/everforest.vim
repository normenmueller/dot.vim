call nemprofile#configure_lightline('everforest')

let g:everforest_background = 'medium'
let g:everforest_better_performance = 1
let g:everforest_enable_italic = 1
let g:everforest_disable_italic_comment = 0

let g:tglthm_profiles = nemprofile#theme_pair('everforest', 'everforest')
let g:tglthm_profiles.dark.background = 'dark'
let g:tglthm_profiles.dark.lightline = 'everforest'
let g:tglthm_profiles.light.background = 'light'
let g:tglthm_profiles.light.lightline = 'everforest'
