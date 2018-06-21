import subprocess
import os

from libqtile.config import Key, Screen, Group, Drag, Match
from libqtile.command import lazy
from libqtile import layout, bar, widget, hook


class Commands(object):
    dmenu = 'dmenu_wrapper'
    # terminal = 'terminator'
    # terminal = 'termite'
    terminal = 'termite --title=tmux -e tmux'
    nm_dmenu = 'networkmanager_dmenu'


wmname = 'LG3D'
mod = 'mod1'

keys = [
    # Window manager controls
    Key([mod, 'control', 'shift'], 'r', lazy.restart()),
    # Key([mod, 'control', 'shift'], 'q', lazy.shutdown()),
    Key([mod], 'r', lazy.spawncmd()),
    Key([mod], 'Return', lazy.spawn(Commands.terminal)),
    Key([mod, 'shift'], 'q', lazy.window.kill()),

    Key([mod], 'o', lazy.layout.next()),
    Key([mod, 'shift'], 'space', lazy.layout.flip()),
    # qtileのトップページに載ってるけどドキュメントに無い
    # Key([mod], 'Left', lazy.screen.prevgroup()),
    # Key([mod], 'Right', lazy.screen.nextgroup()),

    # Layout modification
    Key([mod, 'control'], 'space', lazy.window.toggle_floating()),

    # Switch between windows in current stack pane
    Key([mod], 'h', lazy.layout.left()),
    Key([mod], 'j', lazy.layout.up()),
    Key([mod], 'k', lazy.layout.down()),
    Key([mod], 'l', lazy.layout.right()),

    # Move windows up or down in current stack
    Key([mod, 'shift'], 'h', lazy.layout.swap_left()),
    Key([mod, 'shift'], 'l', lazy.layout.swap_right()),
    Key([mod, 'shift'], 'j', lazy.layout.shuffle_down()),
    Key([mod, 'shift'], 'k', lazy.layout.shuffle_up()),

    # Switch window focus to other pane(s) of stack
    Key([mod], 'space', lazy.layout.next()),

    # Toggle between different layouts as defined below
    Key([mod], 'Tab', lazy.next_layout()),

    # ウィンドウサイズ
    Key([mod], 'i', lazy.layout.grow()),
    Key([mod], 'm', lazy.layout.shrink()),
    Key([mod], 'n', lazy.layout.normalize()),
    Key([mod], 'u', lazy.layout.maximize()),

    # アプリケーション起動
    Key([mod], 'd', lazy.spawn(Commands.dmenu)),
    Key([mod], 'f', lazy.spawn(Commands.nm_dmenu)),
]

# Mouse bindings and options
mouse = (
    Drag([mod], 'Button1', lazy.window.set_position_floating(),
         start=lazy.window.get_position()),
    Drag([mod], 'Button3', lazy.window.set_size_floating(),
         start=lazy.window.get_size()),
)

bring_front_click = False
cursor_warp = False
follow_mouse_focus = True

# Groups
groups = [
    Group('1:term'),
    Group(
        '2:www',
        matches=[Match(wm_class=['firefox', 'Firefox',
                                 'chromium', 'vivaldi-snapshot', 'chrome'])]
    ),
    Group(
        '3:dev',
        matches=[Match(wm_class=['pycharm', 'android-studio', 'idea.sh'])]
    ),
    Group('4:editor'),
    Group('5:work'),
    Group('6:tools'),
    Group(
        '7:IM',
        matches=[Match(wm_class=['pidgin', 'slack', 'slack-desktop'])]
    ),
    Group(
        '8:mail',
        matches=[Match(wm_class=['thunderbird'])]
    ),
    Group(
        '9:SNS',
        matches=[Match(wm_class=['mikutter'])]
    ),
    Group('0:stat'),
]

for i in groups:
    # mod + letter of group = switch to group
    keys.append(Key([mod], i.name[:1], lazy.group[i.name].toscreen()))

    # mod + shift + letter of group = switch to & move focused window to group
    keys.append(Key([mod, 'shift'], i.name[:1], lazy.window.togroup(i.name)))

# 詳細がドキュメントに乗ってないやつ
dgroups_key_binder = None
dgroups_app_rules = []

layouts = [
    layout.Max(),
    layout.MonadTall(),
]

floating_layout = layout.Floating()

# Bar and Screen

bars = {
    'screen1': {
        'top': None,
        'bottom': None,
        'screen_name': 'S1'
    },
    'screen2': {
        'top': None,
        'bottom': None,
        'screen_name': 'S2',
    }
}

_GRAPH_WIDTH = 70

for k, _ in bars.items():
    bars[k]['top'] = bar.Bar(
        [
            widget.GroupBox(),
            widget.CurrentLayout(),
            widget.Prompt(),
            widget.Spacer(),
            widget.Systray(),
            widget.TextBox(text=' | Update '),
            widget.Pacman(),
            widget.TextBox(text=' | Screen:' + bars[k]['screen_name'] + ' |'),
            widget.Clock(format=' %Y-%m-%d %a %H:%M'),
        ],
        25,
    )

    bars[k]['bottom'] = bar.Bar(
        [
            widget.WindowTabs(),
            widget.TextBox(text=' | Battery '),
            widget.Battery(),
            widget.TextBox(text=' | Backlight '),
            widget.Backlight(),
            widget.TextBox(text=' | Sensor '),
            widget.ThermalSensor(),
            widget.TextBox(text=' | Vol '),
            widget.Volume(),
            widget.TextBox(text=' | '),
            widget.TextBox(text='CPU'),
            widget.CPUGraph(width=_GRAPH_WIDTH),
            widget.TextBox(text='Mem'),
            widget.MemoryGraph(width=_GRAPH_WIDTH),
            widget.TextBox(text='Swap'),
            widget.SwapGraph(width=_GRAPH_WIDTH),
            widget.TextBox(text='HDDBusy'),
            widget.HDDBusyGraph(width=_GRAPH_WIDTH),
            widget.TextBox(text='HDD'),
            widget.HDDGraph(width=_GRAPH_WIDTH),
            widget.TextBox(text='Net'),
            widget.NetGraph(width=_GRAPH_WIDTH),
        ],
        20,
        # background=(0, 0, 0, 0),
    )

screens = []

for key, _ in bars.items():
    screens.append(
        Screen(
            top=bars[key]['top'],
            bottom=bars[key]['bottom']
        )
    )

widget_defaults = dict(
    font='RictyDiscord',
    fontsize=16,
    padding=1,
)

auto_fullscreen = True


def main(qtile):
    ''' This function is called when Qtile starts. '''
    pass


@hook.subscribe.startup_once
def auto_start():
    home = os.path.expanduser('~')
    try:
        subprocess.call([home + '/.config/qtile/auto_start.sh'])
    except Exception:
        pass
