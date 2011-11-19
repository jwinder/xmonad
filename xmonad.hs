import XMonad
import XMonad.Util.Run
import XMonad.Util.EZConfig
import XMonad.Actions.CycleWS
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

main = xmonad $ myConfig

myConfig = defaultConfig
           { terminal = myTerminal
           , workspaces = myWorkspaces
           , focusedBorderColor = blue
           , normalBorderColor = black
           , borderWidth = 1
           , modMask = mod4Mask -- masks left-alt to super for xmonad bindings
           , startupHook = myStartupHook
           } `additionalKeysP` myPrettyKeys

myWorkspaces :: [String]
myWorkspaces = [one, two, three, four, five, six, seven, eight, nine]

myPrettyKeys =
    [ ("M-C-r", spawn myTerminal)
    , ("M-C-e", spawn emacs)
    , ("M-C-g", spawn chrome)
    , ("M-C-f", spawn firefox)
    , ("M-C-l", spawn slock)
    , ("M-C-k", spawn volumeDown)
    , ("M-C-j", spawn volumeUp)
    , ("M-C-h", spawn volumeMuteToggle)
    , ("M-i", nextWS)
    , ("M-u", prevWS)
    , ("M-S-i", shiftToNext)
    , ("M-S-u", shiftToPrev)
    ]

myStartupHook = (safeSpawnProg $ home "/.xmonad/startup.sh")
              >> spawn gnomePowerManager
              >> spawn gnomePowerSettings
              >> spawn networkManagerApplet
              >> spawn chorome

--              >> windows $ onWorkspace six W.swapDown . W.shift six >> spawn chrome
--              >> spawnToWorkspace six chrome
--              >> spawn myTerminal
--              >> moveTo Next EmptyWS
--              >> windows W.focusDown >> moveTo Next EmptyWS >> spawn chrome
--              >> windows W.focusDown >> moveTo Next EmptyWS >> spawn myTerminal
--              >> spawn myTerminal
--              >> toggleOrView eight

onWorkspace = \ws -> windows $ W.greedyView ws

spawnOnWorkspace = \ws prog -> do { windows $ W.greedyView ws; spawn prog }

spawnToWorkspace :: String -> String -> X ()
spawnToWorkspace ws prog = do { spawn prog; windows $ W.greedyView ws }

myHome :: String
--myHome = extract $ getEnv "HOME"
myHome = "/home/jwinder"
home :: String -> String
home =  (++) myHome

--myStatusBar :: String
--myStatusBar = "dzen2 -fn '-*-terminus-bold-r-normal-*-10-*-*-*-*-*-*-*' -bg '#000000' -fg '#444444' -h 22 -sa c -x 0 -y 0 -e '' -ta l -xs 1"

myTerminal = "terminator"
emacs = "emacs"
chrome = "google-chrome"
firefox = "firefox"
slock = "slock"
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