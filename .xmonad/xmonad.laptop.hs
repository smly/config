import XMonad
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
import Data.Ratio
import System.IO

myManageHook = composeAll
    [ className =? "Gimp"      --> doFloat
    , className =? "Vncviewer" --> doFloat
    , className =? "MPlayer"   --> doFloat
    ]

main = do
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
        ]

standardLayouts = defaultTall   |||
                  Mirror tiled  |||
                  Full
                where
                  tiled       = Tall nmaster delta ratio
                  defaultTall = ResizableTall 1 (3/100) (1/2) []
                  nmaster     = 1
                  ratio       = toRational (2/(1 + sqrt 5 :: Double)) -- golden, thx Octoploid
                  delta       = 0.03

mostlyTall = ResizableTall 1 (3/100) (1/2) [] ||| Full
