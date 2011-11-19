import XMonad
import XMonad.Util.Run
import XMonad.Util.EZConfig
import XMonad.Actions.CycleWS
import XMonad.Actions.SpawnOn
import Data.Monoid
--import qualified Data.Map as M
--import Control.Monad
--import Control.Comonad
--import System.Environment

--import qualified XMonad.Hooks.DynamicLog as DL
import qualified XMonad.StackSet as W

--http://www.dfki.de/~davi01/files/xmonad.hs

--If you have a dual monitor setup then you use alt + w to change focus to the left monitor and alt + e to change focus to the right monitor. By default, workspace 1 is on the main monitor, workspace 2 is on the second monitor. To switch the workspaces between monitors, just press alt + 2 or alt + 1.
-- And other cool shit:
--http://www.huntlycameron.co.uk/2010/11/how-to-set-up-xmonad-xmobar-ubuntu/

-- Nice example: http://www.offensivethinking.org/data/dotfiles/xmonad/xmonad.hs
-- http://www.haskell.org/haskellwiki/Xmonad/Config_archive

--main = do
--  workspaceBarPipe <- spawnPipe myStatusBar
--  xmonad $ myConfig

main = do { spawner <- mkSpawner; xmonad $ myConfig spawner }
--main = mkSpawner >>= (xmonad $ myConfig)

myConfig spawner = defaultConfig
           { terminal = myTerminal
           , workspaces = myWorkspaces
           , focusedBorderColor = blue
           , normalBorderColor = black
           , borderWidth = 1
           , modMask = mod4Mask -- masks left-alt to super for xmonad bindings
           , manageHook = manageSpawn spawner <+> manageHook defaultConfig
           , startupHook = myStartupHook spawner
           } `additionalKeysP` myPrettyKeys

myWorkspaces :: [String]
myWorkspaces = [one, two, three, four, five, six, seven, eight, nine]

myPrettyKeys =
    [ ("M-C-r", spawn myTerminal)
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

myStartupHook spawner = (safeSpawnProg $ home "/.xmonad/startup.sh")
              >> spawn gnomePowerManager
              >> spawn gnomePowerSettings
              >> spawn networkManagerApplet
              >> spawnOn spawner five myIm
              >> spawnOn spawner four myIrc
              >> spawnOn spawner three myEditorInit
              >> spawnOn spawner two myTerminal
              >> spawnOn spawner one myInternet
--              >> spawnToWorkspacesGreedy spawner [myInternet, myTerminal, myEditor, myIrc, myIm]

myHome :: String
--myHome = extract $ getEnv "HOME"
myHome = "/home/jwinder"
home :: String -> String
home =  (++) myHome

--spawnToWorkspacesGreedy :: Spawner -> [String] -> X ()
--spawnToWorkspacesGreedy spawner programs = do { mapM (\p -> spawnOn spawner (fst p) (snd p)) (reverse $ myWorkspaces zip programs); () }

--myStatusBar :: String
--myStatusBar = "dzen2 -fn '-*-terminus-bold-r-normal-*-10-*-*-*-*-*-*-*' -bg '#000000' -fg '#444444' -h 22 -sa c -x 0 -y 0 -e '' -ta l -xs 1"

myTerminal = "terminator"
myEditorInit = "emacs"
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
