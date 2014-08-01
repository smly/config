-- include hydra-grid (https://github.com/sdegutis/hydra-grid)
require "ext.grid.init"

--
-- boilerplate hydra code
--

-- autostart hydra
hydra.autolaunch.set(true)

-- Hides Hydra's dock icon; Hydra will no longer show up when you Cmd-Tab.
hydra.dockicon.hide()

-- watch for changes
pathwatcher.new(os.getenv("HOME") .. "/.hydra/", hydra.reload):start()

-- notify on start
notify.show("Hydra", ":-)", "", "")

-- show a helpful menu
hydra.menu.show(function()
    local t = {
      {title = "Reload Config", fn = hydra.reload},
      {title = "Open REPL", fn = repl.open},
      {title = "-"},
      {title = "About Hydra", fn = hydra.showabout},
      {title = "Check for Updates...", fn = function() hydra.updates.check(nil, true) end},
      {title = "Quit", fn = os.exit},
    }
    return t
end)

-- when the "update is available" notification is clicked, open the website
notify.register("showupdate", function() os.execute('open https://github.com/sdegutis/Hydra/releases') end)

-- check for updates every week, and also right now (when first launching)
timer.new(timer.weeks(1), hydra.updates.check):start()
hydra.updates.check()


--
-- start custom config
--


ext.grid.MARGINX = 0    -- The margin between each window horizontally
ext.grid.MARGINY = 0    -- The margin between each window vertically
ext.grid.GRIDWIDTH = 8  -- The number of cells wide the grid is

-- moves window into position
function movewindow(pos)
  local grid

  local grid_positions = {
    full = { x = 0, y = 0, w = ext.grid.GRIDWIDTH, h = 2 },
    left_half = { x = 0, y = 0, w = ext.grid.GRIDWIDTH / 2, h = 2 },
    right_half = { x = ext.grid.GRIDWIDTH / 2, y=0, w = ext.grid.GRIDWIDTH / 2, h = 2 },
    left_2_3 = { x = 0, y = 0, w = 7, h = 2 },
    right_2_3 = { x = 1, y = 0, w = 7, h = 2 }
  }

  return function()
    ext.grid.set(window.focusedwindow(), grid_positions[pos], screen.mainscreen())
  end
end

-- keyboard modifier for bindings
local mod1 = {'ctrl', 'cmd'}

fnutils.each({
  { key = 's', pos = 'full' },
  { key = 'a', pos = 'left_half' },
  { key = 'd', pos = 'right_half' },
  { key = '.', pos = 'left_2_3' },
  { key = '/', pos = 'right_2_3' }
}, function(obj)
  hotkey.new(mod1, obj.key, movewindow(obj.pos)):enable()
end)

function application_positions()
  local screen = screen.mainscreen():frame_including_dock_and_menu()

  -- application positions we want for defaults.
  -- allow for setting 'by_window' within an application for more finite control.
  local app_positions = {
    HipChat = { x = 0, y = screen.h - 460, w = 900, h = 460 },
    Atom = { x = 0, y = 0, w = 900, h = 410 },
    Messages = {
      by_window = true,
      Buddies = { x = screen.w - 190, y = 0, w = 190, h = 900 },
      Messages = { x = screen.w - 600, y = screen.h - 360, w = 600, h = 360 }
    },
    iTunes = { x = (screen.w - 1100) / 2, y = 22, w = 1100, h = 725 },

    ['Google Chrome'] = { x = 0, y = 0, w = screen.w - 150, h = screen.h },
    ['Sublime Text'] = { x = 150, y = 0, w = screen.w - 150, h = screen.h },

    iTerm = { x = 0, y = 0, w = screen.w, h = 460 },
    SourceTree = { x = 0, y = screen.h - 720, w = screen.w, h = 720 }
  }

  -- iterate over every visible window in the current screen.
  fnutils.each(window.allwindows(), function(win)
    -- grab the window's application's title.
    local app_title = win:application():title()

    -- save our desired application position
    local app_position = app_positions[app_title]

    -- if we've found an application position then we can position its frame
    if app_position then

      -- if we're setting frame by_window instead of by application
      if app_position.by_window then
        -- iterate over every window open in the application
        fnutils.each(win:application():allwindows(), function(app_window)
          -- get the actual window's title (not the application's)
          local window_title = app_window:title()

          -- if we have a desired position then we can position it!
          if app_position[window_title] then
            app_window:setframe(app_position[window_title])
          end
        end)
      else
        -- set window frame
        win:setframe(app_position)
      end

    end
  end)
end
hotkey.new(mod1, '1', application_positions):enable()

function app_from_name(name)
  return fnutils.find(application.runningapplications(), function(app) return app:title() == name end)
end

function activate_atom(app_name)
  app = app_from_name(app_name)
  if app then
    if app:ishidden() then
      app:unhide()
      app:activate()
    else
      app:activate()
    end
  else
    application.launchorfocus(app_name)
  end
end

hotkey.bind(mod1, 'm', function() activate_atom('Atom') end)
hotkey.bind(mod1, 'h', function() activate_atom('HipChat') end)
hotkey.bind(mod1, 'f', function() activate_atom('Firefox') end)
hotkey.bind(mod1, 't', function() activate_atom('iTerm') end)
hotkey.bind(mod1, 'c', function() activate_atom('Google Chrome') end)
hotkey.bind(mod1, 'y', function() notify.show("Hydra", "Yo!", "", "") end)
