import XMonad
import XMonad.Util.Run
import XMonad.Util.EZConfig
import XMonad.Actions.CycleWS
import XMonad.Actions.SpawnOn
import Data.Monoid
--import System.Environment
--import qualified XMonad.StackSet as W

main = mkSpawner >>= xmonad . myConfig

myConfig spawner = defaultConfig
                   { terminal = myTerminal
                   , workspaces = myWorkspaces
                   , focusedBorderColor = blue
                   , normalBorderColor = black
                   , borderWidth = 1
                   , modMask = mod4Mask -- masks left-alt to super for xmonad bindings
                   , manageHook = manageSpawn spawner <+> manageHook defaultConfig
                   , startupHook = myStartupHook spawner
                   } `removeKeysP` myRemoveKeysP
                     `additionalKeysP` myAdditionalKeysP

myWorkspaces :: [String]
myWorkspaces = [one, two, three, four, five, six, seven, eight, nine]

myAdditionalKeysP =
    [ ("M-p", spawn myMenu)
    , ("M-C-r", spawn myTerminal)
    , ("M-C-e", spawn myEditor)
    , ("M-C-g", spawn myInternet)
    , ("M-C-l", spawn lockScreen)
    , ("M-C-k", spawn volumeDown)
    , ("M-C-j", spawn volumeUp)
    , ("M-C-h", spawn volumeMuteToggle)
    , ("M-i", nextWS)
    , ("M-u", prevWS)
    , ("M-S-i", shiftToNext)
    , ("M-S-u", shiftToPrev)
    ]

myRemoveKeysP = ["M-q"]

myStartupHook spawner = (safeSpawnProg $ home "/.xmonad/keymappings.sh")
                        >> spawn gnomePowerManager
                        >> spawn gnomePowerSettings
                        >> spawn networkManagerApplet
                        >> spawnOn spawner four myIm
                        >> spawnOn spawner three myTerminal
                        >> spawnOn spawner two myEditorInit
                        >> spawnOn spawner one myInternet

--spawnFromHome prog = getEnv "HOME" >>= (\home -> safeSpawnProg $ home ++ prog)

myHome = "/home/jwinder"
home :: String -> String
home =  (++) myHome

myMenu = "dmenu_run"
myTerminal = "terminator"
myEditorInit = "emacs" -- "emacs --daemon"
myEditor = "emacsclient -c"
myInternet = "google-chrome"
myIrc = "xchat"
myIm = "pidgin"
lockScreen = "slock"
volumeUp = "amixer set Master 5%+ unmute > /dev/null"
volumeDown = "amixer set Master 5%- > /dev/null"
volumeMuteToggle = "amixer sset Master toggle > /dev/null"
gnomePowerManager = "gnome-power-manager"
gnomePowerSettings = "gnome-power-settings"
networkManagerApplet = "nm-applet"

blue = "#0000FF"
black = "#000000"

one = "1"
two = "2"
three = "3"
four = "4"
five = "5"
six = "6"
seven = "7"
eight = "8"
nine = "9"
