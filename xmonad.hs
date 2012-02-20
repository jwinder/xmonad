import XMonad
import XMonad.Util.Run
import XMonad.Util.EZConfig
import XMonad.Actions.CycleWS
import XMonad.Actions.SpawnOn
import XMonad.Hooks.SetWMName
import Data.Monoid
--import System.Environment
--import qualified XMonad.StackSet as W

main = mkSpawner >>= xmonad . myConfig

myConfig spawner = defaultConfig
                   { terminal           = myTerminal
                   , workspaces         = myWorkspaces
                   , focusedBorderColor = blue
                   , normalBorderColor  = black
                   , borderWidth        = 2
                   , modMask            = mod4Mask -- masks left-alt to super for xmonad bindings
                   , manageHook         = manageSpawn spawner <+> manageHook defaultConfig
                   , startupHook        = myStartupHook spawner
                   } `removeKeysP` myRemoveKeysP
                     `additionalKeysP` myAdditionalKeysP

myWorkspaces = [one, two, three, four, five, six, seven, eight, nine]

myAdditionalKeysP =
    [ ("M-p", spawn myMenu)
    , ("M-S-w", spawn shutdownSystem)
    , ("M-C-t", spawn myTerminal)
    , ("M-C-e", spawn myEditor)
    , ("M-C-g", spawn myInternet)
    , ("M-C-l", spawn lockScreen)
--    , ("M-C-k", spawn volumeDown)
--    , ("M-C-j", spawn volumeUp)
--    , ("M-C-h", spawn volumeMuteToggle)
    , ("M-i", nextWS)
    , ("M-u", prevWS)
    , ("M-S-i", shiftToNext)
    , ("M-S-u", shiftToPrev)
    ]

myRemoveKeysP = ["M-q"]

myStartupHook spawner = setWMName "LG3D"
--                        >> spawn "gnome-session"
                        >> spawn "gnome-settings-daemon"
                        >> spawn keyMappings
--                        >> spawn gnomePowerManager
--                        >> spawn gnomePowerSettings
--                        >> spawn networkManagerApplet
--                        >> spawn dropboxStart
--                        >> spawnOn spawner nine nvidiaMenu
--                        >> spawnOn spawner four myIm
--                        >> spawnOn spawner three myTerminal
--                        >> spawnOn spawner two myEditorInit
--                        >> spawnOn spawner one myInternet

keyMappings          = "$HOME/.xmonad/keymappings.sh"
myMenu               = "dmenu_run"
shutdownSystem       = "dbus-send --system --print-reply --dest=\"org.freedesktop.ConsoleKit\" /org/freedesktop/ConsoleKit/Manager org.freedesktop.ConsoleKit.Manager.Stop"
myTerminal           = "gnome-terminal"
myEditorInit         = "emacs"
myEditor             = "emacsclient -c"
myInternet           = "google-chrome"
--myIm                 = "pidgin"
lockScreen           = "slock"
volumeUp             = "amixer set Master 5%+ unmute > /dev/null"
volumeDown           = "amixer set Master 5%- > /dev/null"
volumeMuteToggle     = "amixer sset Master toggle > /dev/null"
gnomePowerManager    = "gnome-power-manager"
gnomePowerSettings   = "gnome-power-settings"
networkManagerApplet = "nm-applet"
dropboxStart         = "python $HOME/bin/dropbox.py start"
nvidiaMenu           = "nvidia-settings"

blue  = "#0000FF"
black = "#000000"

one   = "1"
two   = "2"
three = "3"
four  = "4"
five  = "5"
six   = "6"
seven = "7"
eight = "8"
nine  = "9"
