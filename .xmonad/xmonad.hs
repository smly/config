{-# OPTIONS_GHC -Wall -fno-warn-missing-signatures #-}
{-# LANGUAGE NoMonomorphismRestriction #-}
{-# LANGUAGE PatternGuards #-}

import XMonad
import qualified Data.Map as M
import qualified XMonad.StackSet as W
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.EZConfig(additionalKeys)
import XMonad.Layout.NoBorders (smartBorders)
import XMonad.Layout.Grid (Grid(..))
import XMonad.Layout.PerWorkspace (onWorkspace)
import XMonad.Layout.ResizableTile (ResizableTall(..))
import XMonad.Layout.Magnifier (magnifiercz)
import XMonad.Layout.MagicFocus
import XMonad.Layout.ThreeColumns
import XMonad.Layout.Dishes
import XMonad.Layout.DragPane
import XMonad.Layout.ComboP -- 
import XMonad.Actions.GridSelect
import XMonad.Actions.WindowBringer (bringWindow)
import Data.Ratio
import System.IO

myManageHook = composeAll
    [ className =? "Gimp"      --> doFloat
    , className =? "Vncviewer" --> doFloat
    , className =? "MPlayer"   --> doFloat
    ]

main = do
    spawn "xlock -mode demon" -- lock desktop first!
    xmproc <- spawnPipe "/usr/bin/xmobar /home/smly/.xmobarrc"
    xmonad $ defaultConfig
        { manageHook = manageDocks <+> myManageHook
                        <+> manageHook defaultConfig
--        , layoutHook = avoidStruts  $  layoutHook defaultConfig
        , layoutHook = avoidStruts $
                       smartBorders (
--                                     onWorkspace "dev1" grids $
                                     onWorkspace "web4" mostlyTall standardLayouts)
        , logHook = dynamicLogWithPP $ xmobarPP
                        { ppOutput = hPutStrLn xmproc
                        , ppTitle = xmobarColor "#f07777" "" . shorten 50
                        }
        , modMask = mod4Mask     -- Rebind Mod to the Windows key
        , terminal = "urxvt"
        , focusFollowsMouse = False
        , borderWidth = 1
        , workspaces = ["dev1","dev2","dev3","web4"] ++ map show [5..9]
        , normalBorderColor  = "#222222"
        , focusedBorderColor = "#c00000"
        } `additionalKeys`
        [ ((mod4Mask .|. shiftMask, xK_z), spawn "xlock -mode demon")
        , ((controlMask, xK_Print), spawn "sleep 0.2; scrot -s")
        , ((0, xK_Print), spawn "scrot")
        , ((mod4Mask .|. shiftMask, xK_b), sendMessage ToggleStruts)
--        , ((mod4Mask, xK_g), goToSelected $ gsconfig3 greenColorizer)
        , ((mod4Mask, xK_g), goToSelected $ gsconfig3 defaultColorizer)
        , ((mod4Mask, xK_f), bringSelected $ gsconfig3 defaultColorizer)
        , ((mod4Mask, xK_s), spawnSelected defaultGSConfig commands)
        ]
            where
              commands = ["urxvt", "wicd-client -n", "firefox", "mute", "unmute80"]

standardLayouts = defaultTall   |||
--                  Mirror tiled  |||
                  Grid |||
                  Dishes 2 (1/7) |||
                  dragPane Horizontal 0.1 0.5 |||
                  dragPane Vertical 0.1 0.5 |||
                  ThreeCol 1 (3/100) (1/2) |||
                  Full
                where
                  tiled       = Tall nmaster delta ratio
                  defaultTall = ResizableTall 1 (3/100) (1/2) []
                  nmaster     = 1
                  ratio       = toRational (2/(1 + sqrt 5 :: Double)) -- golden, thx Octoploid
                  delta       = 0.03

mostlyTall = ResizableTall 1 (3/100) (1/2) [] ||| Full

gsconfig3 colorizer = (buildDefaultGSConfig colorizer)
    { gs_cellheight = 30
    , gs_cellwidth = 100
    , gs_navigate = M.unions
            [reset
            ,nethackKeys
            ,gs_navigate                               -- get the default navigation bindings
                $ defaultGSConfig `asTypeOf` (gsconfig3 colorizer)
            -- needed to fix an ambiguous type variable
            ]
    }
   where addPair (a,b) (x,y) = (a+x,b+y)
         nethackKeys = M.map addPair $ M.fromList
                               [((0,xK_y),(-1,-1))
                               ,((0,xK_i),(1,-1))
                               ,((0,xK_n),(-1,1))
                               ,((0,xK_m),(1,1))
                               ]
         -- jump back to the center with the spacebar, regardless of the current position.
         reset = M.singleton (0,xK_space) (const (0,0))

greenColorizer = colorRangeFromClassName
                 black            -- lowest inactive bg
                 (0x70,0xFF,0x70) -- highest inactive bg
                 black            -- active bg
                 white            -- inactive fg
                 white            -- active fg
    where black = minBound
          white = maxBound
