import XMonad
import XMonad.Util.Run
import XMonad.Util.EZConfig
--import XMonad.Actions.SpawnOn
import Data.Monoid
--import Control.Comonad
import System.Environment

-- Nice example: http://www.offensivethinking.org/data/dotfiles/xmonad/xmonad.hs
-- http://www.haskell.org/haskellwiki/Xmonad/Config_archive

main = xmonad $ myConfig

myConfig = defaultConfig
           { terminal = myTerminal
           , workspaces = myWorkspaces
           , focusedBorderColor = blue
           , normalBorderColor = black
           , borderWidth = 1
           , modMask = mod4Mask -- masks left-alt to super for xmonad bindings
           , startupHook = myStartupHook
           } `additionalKeysP` myKeyBindings

myWorkspaces = map show $ [1..9] ++ [0]

myKeyBindings =
    [ ("M-C-r", spawn myTerminal)
    , ("M-C-e", spawn emacs)
    , ("M-C-g", spawn chrome)
    , ("M-C-f", spawn firefox)
    , ("M-C-l", spawn slock)
    , ("M-C-k", spawn volumeDown)
    , ("M-C-j", spawn volumeUp)
    ]

myStartupHook = (safeSpawnProg $ home "./.xmonad/startup.sh")
              >> spawn gnomePowerSettings
              >> spawn networkManagerApplet
              >> spawn myTerminal

--myHome = extract $ getEnv "HOME"
myHome = "/home/jwinder"
home :: String -> String
home = (++) myHome

myTerminal = "terminator"
emacs = "emacs"
chrome = "google-chrome"
firefox = "firefox"
slock = "slock"
volumeUp = "amixer set Master 5%+ > /dev/null"
volumeDown = "amixer set Master 5%- > /dev/null"
gnomePowerSettings = "gnome-power-settings"
networkManagerApplet = "nm-applet"

blue = "#0000FF"
black = "#000000"