import XMonad
import XMonad.Util.Run
import XMonad.Util.EZConfig
import XMonad.Actions.SpawnOn
--import XMonad.Actions.Volume -- this is located in xmonad-extras, get it!
--import XMonad.Util.Dzen
import Data.Monoid
import System.Environment

-- Nice example: http://www.offensivethinking.org/data/dotfiles/xmonad/xmonad.hs
-- http://www.haskell.org/haskellwiki/Xmonad/Config_archive

main = xmonad $ myConfig

myConfig = defaultConfig
           { terminal = myTerminal
           , workspaces = myWorkspaces
           , focusedBorderColor = myFocusedBorderColor
           , normalBorderColor = myNormalBorderColor
           , borderWidth = myBorderWidth
           , modMask = mod4Mask
           , startupHook = myStartupHook
           } `additionalKeysP` myKeyBindings

myKeyBindings =
    [ ("M-C-r", spawn myTerminal)
    , ("M-C-e", spawn "emacs")
    , ("M-C-g", spawn "google-chrome")
    , ("M-C-f", spawn "firefox")
    , ("M-C-l", spawn "slock") -- simple screen locking
    , ("M-C-k", spawn "amixer set Master 5%- > /dev/null") -- raise volume
    , ("M-C-j", spawn "amixer set Master 5%+ > /dev/null") -- lower volume
    ]

myStartupHook = (safeSpawnProg $ home "./.xmonad/startup.sh")
              >> spawn "gnome-power-settings"
              >> spawn "nm-applet"
              >> spawn myTerminal

--myHome = getEnv "HOME"
myHome = "/home/jwinder"
home :: String -> String
home directory = myHome ++ directory

myTerminal = "terminator"
myFocusedBorderColor = "#0000FF"
myNormalBorderColor = "#000000"
myBorderWidth = 1
myWorkspaces = map show $ [1..9] ++ [0]
