import XMonad
import XMonad.Util.Run
import XMonad.Util.EZConfig
import XMonad.Actions.CycleWS
import XMonad.Actions.SpawnOn
import XMonad.Hooks.SetWMName
import Data.Monoid

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
    , ("M-C-r", spawn myTerminal)
    , ("M-C-e", spawn myEditor)
    , ("M-C-g", spawn myInternet)
    , ("M-C-l", spawn lockScreen)
    , ("M-i", nextWS)
    , ("M-u", prevWS)
    , ("M-S-i", shiftToNext)
    , ("M-S-u", shiftToPrev)
    ]

myRemoveKeysP = ["M-q"]

myStartupHook spawner = setWMName "LG3D"
                        >> spawn "feh --bg-scale $HOME/.xmonad/background.png"
                        >> spawn "xcompmgr &"
                        >> spawn "gnome-settings-daemon" -- shortcuts: M-C-h toggle volume, M-C-j raise volume, M-C-k lower volume
                        >> spawn "nm-applet"
                        >> spawn "$HOME/.xmonad/keymappings.sh"
                        >> spawn "sleep 4s"
                        >> spawn "python $HOME/bin/dropbox.py start"
                        >> spawnOn spawner nine nvidiaMenu
                        >> spawnOn spawner four myIm
                        >> spawnOn spawner three myTerminal
                        >> spawnOn spawner two myEditorInit
                        >> spawnOn spawner one myInternet

myMenu         = "dmenu_run"
shutdownSystem = "dbus-send --system --print-reply --dest=\"org.freedesktop.ConsoleKit\" /org/freedesktop/ConsoleKit/Manager org.freedesktop.ConsoleKit.Manager.Stop"
myTerminal     = "gnome-terminal"
myEditorInit   = "emacs"
myEditor       = "emacsclient -c"
myInternet     = "google-chrome"
myIm           = "pidgin"
lockScreen     = "slock"
nvidiaMenu     = "nvidia-settings"

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
