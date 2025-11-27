import Data.Map qualified as M
import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.StatusBar
import XMonad.Hooks.StatusBar.PP
import XMonad.Hooks.InsertPosition
import XMonad.Layout.NoBorders
import XMonad.Layout.ResizableTile
import XMonad.Layout.Spacing
import XMonad.Layout.Spiral
import XMonad.Layout.Renamed
import XMonad.StackSet qualified as W
import XMonad.Util.EZConfig (additionalKeysP)
import XMonad.Util.Loggers
import XMonad.Util.SpawnOnce

-- TokyoNight Colors
colorBg = "#1a1b26" -- background
colorFg = "#a9b1d6" -- foreground
colorBlk = "#32344a" -- black
colorRed = "#f7768e" -- red
colorGrn = "#9ece6a" -- green
colorYlw = "#e0af68" -- yellow
colorBlu = "#7aa2f7" -- blue
colorMag = "#ad8ee6" -- magenta
colorCyn = "#0db9d7" -- cyan
colorBrBlk = "#444b6a" -- bright black

-- Appearance
myBorderWidth = 2

myNormalBorderColor = colorBrBlk

myFocusedBorderColor = colorMag

-- Gaps (matching dwm: 3px all around)
mySpacing = spacingWithEdge 3

-- Workspaces
myWorkspaces = ["1", "2", "3", "4", "5", "6", "7", "8", "9"]

-- Mod key (Super/Windows key)
myModMask = mod4Mask

-- Terminal
myTerminal = "st"

-- Layouts
myLayoutHook =
  avoidStruts $
        renamed [Replace "Tall"] (mySpacing tall)
        ||| renamed [Replace "Wide"] (mySpacing (Mirror tall))
        ||| renamed [Replace "Full"] (mySpacing Full)
        ||| renamed [Replace "Spiral"] (mySpacing (spiral (6 / 7)))
  where
    tall = ResizableTall 1 (3 / 100) (11 / 20) []

-- Window rules (matching dwm config)
myManageHook =
  composeAll
    [ className =? "Gimp" --> doFloat
    , className =? "Brave-browser" --> doShift "2"
    , className =? "firefox" --> doShift "3"
    , className =? "Slack" --> doShift "4"
    , className =? "kdenlive" --> doShift "8"
    ]
    <+> insertPosition Below Newer

-- Key bindings (matching dwm as closely as possible)
myKeys =
  -- Launch applications
  [ ("M-<Return>", spawn myTerminal)
  , ("M-d", spawn "rofi -show drun -theme ~/.config/rofi/config.rasi")
  , ("M-r", spawn "dmenu_run")
  , ("M-l", spawn "slock")
  , ("C-<Print>", spawn "maim -s | xclip -selection clipboard -t image/png")
  , -- Window management
    ("M-q", kill)
  , ("M-j", windows W.focusDown)
  , ("M-k", windows W.focusUp)
  , ("M-<Tab>", windows W.focusDown)
  , -- Master area
    ("M-h", sendMessage Expand)
  , ("M-g", sendMessage Shrink)
  , ("M-i", sendMessage (IncMasterN 1))
  , ("M-p", sendMessage (IncMasterN (-1)))
  , -- Layout switching
    ("M-t", sendMessage $ JumpToLayout "Tall")
  , ("M-f", sendMessage $ JumpToLayout "Full")
  , ("M-c", sendMessage $ JumpToLayout "Spiral")
  , ("M-S-<Return>", sendMessage NextLayout)
  , ("M-n", sendMessage NextLayout)
  , -- Floating
    ("M-S-<Space>", withFocused toggleFloat)
  , -- Gaps (z to increase, x to decrease, a to toggle)
    ("M-z", incWindowSpacing 3)
  , ("M-x", decWindowSpacing 3)
  , ("M-a", toggleWindowSpacingEnabled >> toggleScreenSpacingEnabled)
  , ("M-S-a", setWindowSpacing (Border 3 3 3 3) >> setScreenSpacing (Border 3 3 3 3))
  , -- Quit/Restart
    ("M-S-r", spawn "xmonad --recompile && xmonad --restart")
  , -- Keychords for tag navigation (Mod+Space then number)
    ("M-<Space> 1", windows $ W.greedyView "1")
  , ("M-<Space> 2", windows $ W.greedyView "2")
  , ("M-<Space> 3", windows $ W.greedyView "3")
  , ("M-<Space> 4", windows $ W.greedyView "4")
  , ("M-<Space> 5", windows $ W.greedyView "5")
  , ("M-<Space> 6", windows $ W.greedyView "6")
  , ("M-<Space> 7", windows $ W.greedyView "7")
  , ("M-<Space> 8", windows $ W.greedyView "8")
  , ("M-<Space> 9", windows $ W.greedyView "9")
  , ("M-<Space> f", spawn "firefox")
  , -- Volume controls
    ("<XF86AudioRaiseVolume>", spawn "pactl set-sink-volume @DEFAULT_SINK@ +3%")
  , ("<XF86AudioLowerVolume>", spawn "pactl set-sink-volume @DEFAULT_SINK@ -3%")
  , ("<XF86AudioMute>", spawn "pactl set-sink-mute @DEFAULT_SINK@ toggle")
  ]
    ++
    -- Standard TAGKEYS behavior (Mod+# to view, Mod+Shift+# to move)
    [ (mask ++ "M-" ++ [key], windows $ action tag)
    | (tag, key) <- zip myWorkspaces "123456789"
    , (action, mask) <- [(W.greedyView, ""), (W.shift, "S-")]
    ]

-- Helper function for toggling float
toggleFloat w =
  windows
    ( \s ->
        if M.member w (W.floating s)
          then W.sink w s
          else W.float w (W.RationalRect 0.15 0.15 0.7 0.7) s
    )

-- XMobar PP (Pretty Printer) configuration
myXmobarPP :: PP
myXmobarPP =
  def
    { ppSep = xmobarColor colorBrBlk "" " │ "
    , ppTitleSanitize = xmobarStrip
    , ppCurrent = xmobarColor colorCyn ""
    , ppHidden = xmobarColor colorFg ""
    , ppHiddenNoWindows = xmobarColor colorBrBlk ""
    , ppUrgent = xmobarColor colorRed colorYlw
    , ppOrder = \[ws, l, _, wins] -> [ws, l, wins]
    , ppExtras = [logTitles formatFocused formatUnfocused]
    }
  where
    formatFocused = wrap (xmobarColor colorCyn "" "[") (xmobarColor colorCyn "" "]") . xmobarColor colorFg "" . ppWindow
    formatUnfocused = wrap (xmobarColor colorBrBlk "" "[") (xmobarColor colorBrBlk "" "]") . xmobarColor colorBrBlk "" . ppWindow
    ppWindow :: String -> String
    ppWindow = xmobarRaw . (\w -> if null w then "untitled" else w) . shorten 30

-- Main configuration
myConfig =
  def
    { modMask = myModMask
    , terminal = myTerminal
    , workspaces = myWorkspaces
    , borderWidth = myBorderWidth
    , normalBorderColor = myNormalBorderColor
    , focusedBorderColor = myFocusedBorderColor
    , layoutHook = myLayoutHook
    , manageHook = myManageHook <+> manageDocks
    , startupHook = spawnOnce "xsetroot -cursor_name left_ptr"
    }
    `additionalKeysP` myKeys

-- XMobar status bar configuration
myStatusBar = statusBarProp "xmobar ~/.config/xmobar/xmobarrc" (pure myXmobarPP)

main :: IO ()
main = xmonad . ewmhFullscreen . ewmh . withEasySB myStatusBar defToggleStrutsKey $ myConfig
