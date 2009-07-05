import XMonad
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.EwmhDesktops

import qualified XMonad.StackSet as W
import Data.Bits ((.|.))
import System.Exit
import System.IO
import qualified Data.Map as M

import XMonad.Layout.TwoPane
import XMonad.Layout.ResizableTile
import XMonad.Layout.Tabbed
import XMonad.Layout.Combo
import XMonad.Layout.WindowNavigation
import XMonad.Layout.Circle

import XMonad.Actions.CycleWS
import XMonad.Actions.SwapWorkspaces
import XMonad.Actions.Submap
import XMonad.Actions.DwmPromote

import XMonad.Util.EZConfig
import XMonad.Util.Run (spawnPipe)

main = do
  xmobar <- spawnPipe "xmobar"
  xmonad $ defaultConfig
       { borderWidth        = 3
       , focusedBorderColor = "#C11B17"
       , normalBorderColor  = "#2e3436"
       , manageHook         = myManageHook <+> manageDocks
       , workspaces         = map show [1 .. 9 :: Int]
       , terminal           = "urxvt"
       , modMask            = mod4Mask
       , logHook            = myLogHook
       , layoutHook         = windowNavigation $ (avoidStruts (myTab ||| tall ||| Mirror tall ||| Circle))
       , keys               = myKeys
       }
    where
      tall = ResizableTall 1 (3/100) (1/2) []

myTab = tabbed shrinkText myTabConfig

myTabConfig = defaultTheme
    { activeColor         = "#C11B17"
    , inactiveColor       = "#7E2217"
    , urgentColor         = "#C500C5"
    , activeBorderColor   = "white"
    , inactiveBorderColor = "grey"
    , activeTextColor     = "white"
    , inactiveTextColor   = "grey"
    , decoHeight          = 12
    , fontName            = "-mplus-gothic-medium-r-normal-r-12-*-*-*-*-*-*-*"
    }

myLogHook :: X ()
myLogHook = do ewmhDesktopsLogHook
               return ()

myManageHook = composeAll
               [ className =? "MPlayer"          --> doFloat
               , className =? "Gimp"            --> doFloat
               , className =? "Thunar"           --> doFloat
               , className =? "VLC media player" --> doFloat
               , className =? "Thunderbird-bin"  --> doF(W.shift "3")
               , className =? "Pidgin"           --> doF(W.shift "1")
               , className =? "Minefield"        --> doF(W.shift "2")
               , resource  =? "amarokapp"        --> doF(W.shift "5")
               , className =? "Gimmix"           --> doF(W.shift "5")
               , resource  =? "desktop_window"   --> doIgnore
               , className =? "Xfce4-panel"      --> doFloat
               , className =? "Xfce-mcs-manager" --> doFloat
               , className =? "Xfce-mixer"       --> doFloat
               , className =? "Gui.py"           --> doFloat
               , manageDocks]

myKeys = \conf -> mkKeymap conf $
         -- lunching and killing programs
         [ ("M-S-<Return>", spawn $ XMonad.terminal conf)
         , ("M-p", spawn  "exe=`dmenu_path | dmenu` && eval \"exec $exe\"")
         , ("M-S-c", kill)
         -- Lunch gmrun
         , ("M-<Space>", sendMessage NextLayout)
         , ("M-S-<Space>", setLayout $ XMonad.layoutHook conf) -- Reset the layouts on the current workspace to default
         , ("M-n", refresh) -- resize viewed windows to the correct size
         -- move focus up or down the window stack
         , ("M-j", windows W.focusDown)
         , ("M-k", windows W.focusUp)
         , ("M-m", windows W.focusMaster)
         -- modifying the window order
         , ("M-<Return>", windows W.swapMaster)
         , ("M-S-j", windows W.swapDown)
         , ("M-S-k", windows W.swapUp)
         -- resizing the window order
         , ("M-h", sendMessage Shrink)
         , ("M-l", sendMessage Expand)
         -- floating layout support
         , ("M-t", withFocused $ windows . W.sink)
--         , ("M-d", withFocused $ windows . W.sink)
         -- increase or decrease number of window in the master area
         , ("M-,", sendMessage (IncMasterN 1))
         , ("M-.", sendMessage (IncMasterN (-1)))
         -- quit, or restart
         , ("M-S-q", io (exitWith ExitSuccess))
         , ("M-x q", restart "xmonad" True)

         -- , ("M-x p", dwmpromote) --might change this to M-<Return>
         -- , ("M-S-s", sendMessage MirrorShrink)
         -- , ("M-S-e", sendMessage MirrorExpand)

         -- increase/decrease transparency
         -- , ("M-t", spawn "transset-df -a --dec .1")
         -- , ("M-S-t", spawn "transset-df -a --inc .1")
         ]
         ++
         -- M-[1..9] %! switch to workspace N
         -- M-S-[1..9] %! move client to workspace N
         [ (m ++ i, windows $ f j)
           | (i, j) <- zip (map show [1..9]) (XMonad.workspaces conf)
         , (m, f) <- [("M-", W.greedyView), ("M-S-", W.shift)]
         ]
         ++
         -- switch to physical/Xinerama screens
         [ (m ++ key, screenWorkspace sc >>= flip whenJust (windows . f))
           | (key, sc) <- zip ["w", "e", "q"] [0..]
         , (m, f) <- [("M-", W.view), ("M-S-", W.shift)]
         ]
         -- ++
         --Multimedia keys
         -- [
         -- ("M-v", spawn "aumix -v -3")
         -- , ("M-S-v", spawn "aumix -v +5")
         -- , ("M-a p", spawn "mpc toggle") --meta-Audio <previous>
         -- , ("M-a ,", spawn "mpc prev")
         -- , ("M-a .", spawn "mpc next")
         -- ]
