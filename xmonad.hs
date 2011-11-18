import XMonad
import XMonad.Util.Run
import XMonad.Util.EZConfig
--import XMonad.Actions.Volume -- this is located in xmonad-extras, get it!
import XMonad.Util.Dzen
import Data.Monoid
import System.Environment

-- Nice example: http://www.offensivethinking.org/data/dotfiles/xmonad/xmonad.hs
-- http://www.haskell.org/haskellwiki/Xmonad/Config_archive

main = xmonad $ defaultConfig
       { terminal = myTerminal
       , workspaces = myWorkspaces
       , focusedBorderColor = myFocusedBorderColor
       , normalBorderColor = myNormalBorderColor
       , borderWidth = myBorderWidth
       , startupHook = myStartupHook
       , modMask = mod4Mask
       } `additionalKeysP` myKeyBindings

myKeyBindings =
    [ ("M-C-r", spawn "terminator")
    , ("M-C-e", spawn "emacs")
    , ("M-C-g", spawn "google-chrome")
    , ("M-C-f", spawn "firefox")
    , ("M-C-l", spawn "slock")
    ]

myStartupHook = (safeSpawnProg $ home "/.xmonad/keymappings.sh")
              >> spawn "gnome-power-settings"
              >> spawn "nm-applet"
              >> spawn "terminator"

--myHome = getEnv "HOME"
myHome = "/home/jwinder"
home :: String -> String
home directory = myHome ++ directory

myTerminal = "terminator"
myFocusedBorderColor = "#0000FF"
myNormalBorderColor = "#000000"
myBorderWidth = 1
myWorkspaces = ["1:Alpha", "2:Beta", "3:Gamma", "4:Delta", "5:Epsilon", "6:Zeta", "7:Eta", "8:Theta", "9:Iota", "0:Kappa"]

--myMappends =
--    [ ((0, XF86AudioLowerVolume), lowerVolume 4 >>= alertVol )
--    , ((0, XF86AudioRaiseVolume), raiseVolume 4 >>= alertVol )
--    ]
--alertVol = dzenConfig return .show

