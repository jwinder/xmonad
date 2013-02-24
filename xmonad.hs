import XMonad
import XMonad.Util.EZConfig
import XMonad.Actions.CycleWS
import XMonad.Actions.SpawnOn
import XMonad.Hooks.SetWMName
import Data.Monoid

main = xmonad $ defaultConfig
       { terminal           = myTerminal
       , workspaces         = myWorkspaces
       , focusedBorderColor = blue
       , normalBorderColor  = black
       , borderWidth        = 2
       , modMask            = mod4Mask -- masks left-alt to super for xmonad bindings
       , manageHook         = manageSpawn <+> manageHook defaultConfig
       , startupHook        = myStartupHook
       } `removeKeysP` myRemoveKeysP
         `additionalKeysP` myAdditionalKeysP

myWorkspaces = [one, two, three, four, five, six, seven, eight, nine]

myAdditionalKeysP =
    [ ("M-p", spawnHere myMenu)
    , ("M-S-w", spawnHere shutdownSystem)
    , ("M-C-r", spawnHere myTerminal)
    , ("M-C-e", spawnHere myEditor)
    , ("M-C-t", spawnHere myEditorInit)
    , ("M-C-g", spawnHere myInternet)
    , ("M-i", nextWS)
    , ("M-u", prevWS)
    , ("M-S-i", shiftToNext)
    , ("M-S-u", shiftToPrev)
    ]

myRemoveKeysP = ["M-q"]

myStartupHook = setWMName "LG3D"
                >> spawnHere "gnome-settings-daemon"
                >> spawnHere "nm-applet"
                >> spawnHere "feh --bg-scale $HOME/.xmonad/background.png"
                >> spawnHere "xcompmgr"
                >> spawnHere "python $HOME/bin/dropbox.py start"
                >> spawnHere "$HOME/.xmonad/passbackups.sh"
                >> spawnHere "$HOME/.xmonad/keymappings.sh"
                >> spawnHere "sleep 15; $HOME/.xmonad/brightness.sh"
                >> spawnOn nine nvidiaMenu
                >> spawnOn four myMusic
--                >> spawnOn four myIm
                >> spawnOn three myTerminal
--                >> spawnOn two myEditorInit
                >> spawnOn one myInternet

myMenu         = "dmenu_run"
shutdownSystem = "dbus-send --system --print-reply --dest=\"org.freedesktop.ConsoleKit\" /org/freedesktop/ConsoleKit/Manager org.freedesktop.ConsoleKit.Manager.Stop"
myTerminal     = "gnome-terminal"
myEditorInit   = "emacs"
myEditor       = "emacsclient -c"
myInternet     = "google-chrome"
myIm           = "pidgin"
myMusic        = "audacious"

nvidiaMenu     = "nvidia-settings"
gnomeControl   = "gnome-control-center"

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
