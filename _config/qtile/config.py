import subprocess, os
from libqtile.config import Key, Screen, Group, Drag, Click, Match
from libqtile.command import lazy
from libqtile import layout, bar, widget, hook

widget_defaults = dict(
    font='RictyDiscord',
    fontsize=16,
    padding=1,
)


class Commands(object):
    dmenu = 'dmenu_run'
    terminator = 'terminator'


mod = "mod1"

keys = [
    # General functions
    Key([mod], "r", lazy.spawncmd()),
    Key([mod, "control"], "r", lazy.restart()),
    Key([mod, "control", "shift"], "q", lazy.shutdown()),

    # Group functions
    # ウィンドウレイアウト変更
    Key([mod], "Tab", lazy.next_layout()),
    Key([mod, "shift"], "Tab", lazy.prev_layout()),

    # Window functions
    # フォーカスウィンドウを閉じる
    Key([mod, "shift"], "q", lazy.window.kill()),
    # フォーカス切り替え
    Key([mod], "o", lazy.layout.next()),
    Key([mod, "shift"], "o", lazy.layout.previous()),

    # ウィンドウ移動
    Key([mod], "h", lazy.layout.left()),
    Key([mod], "j", lazy.layout.up()),
    Key([mod], "k", lazy.layout.down()),
    Key([mod], "l", lazy.layout.right()),

    # ウィンドウ位置変更
    Key([mod, "shift"], "h", lazy.layout.swap_left()),
    Key([mod, "shift"], "l", lazy.layout.swap_right()),
    Key([mod, "shift"], "j", lazy.layout.shuffle_down()),
    Key([mod, "shift"], "k", lazy.layout.shuffle_up()),
    Key([mod, "shift"], "space", lazy.layout.flip()),

    # ウィンドウサイズ
    Key([mod], "i", lazy.layout.grow()),
    Key([mod], "m", lazy.layout.shrink()),
    Key([mod], "n", lazy.layout.normalize()),
    Key([mod], "u", lazy.layout.maximize()),

    # アプリケーション起動
    Key([mod], "Return", lazy.spawn(Commands.terminator)),
    Key([mod], "d", lazy.spawn(Commands.dmenu)),

    # ???
    Key([mod, "shift"], "Return", lazy.layout.toggle_split()),
]

groups = [
    Group('1:term'),
    Group(
        '2:www',
        matches=[Match(wm_class=['firefox', 'chromium', 'vivaldi-snapshot'])]
    ),
    Group(
        '3:work',
        matches=[Match(wm_class=['pycharm', 'android-studio', 'idea.sh'])]
    ),
    Group('4:None'),
    Group('5:None'),
    Group('6:stat'),
    Group(
        '7:IM',
        matches=[Match(wm_class=['pidgin', 'slack'])]
    ),
    Group(
        '8:mail',
        matches=[Match(wm_class=['thunderbird'])]
    ),
    Group(
        '9:SNS',
        matches=[Match(wm_class=['mikutter'])]
    ),
    Group(
        '0:tools',
        matches=[Match(wm_class=['shutter', 'owncloud'])]
    ),
]

for i in groups:
    keys.append(Key([mod], i.name[:1], lazy.group[i.name].toscreen()))
    keys.append(Key([mod, "shift"], i.name[:1], lazy.window.togroup(i.name)))

layouts = [
    layout.Max(),
    layout.Stack(num_stacks=2),
    layout.MonadTall(),
]

screens = [
    Screen(
        top=bar.Bar(
            [
                widget.GroupBox(),
                widget.CurrentLayout(),
                widget.Prompt(),
                widget.Spacer(),
                widget.Systray(),
                widget.Pacman(),
                widget.CPUGraph(),
                widget.MemoryGraph(),
                widget.Battery(),
                widget.Clock(format=' %Y-%m-%d %a %H:%M'),
            ],
            25,
        ),
    ),
]

mouse = [
    Drag([mod], "Button1", lazy.window.set_position_floating(),
         start=lazy.window.get_position()),
    Drag([mod], "Button3", lazy.window.set_size_floating(),
         start=lazy.window.get_size()),
    Click([mod], "Button2", lazy.window.bring_to_front())
]

# サンプルそのまま
dgroups_key_binder = None
dgroups_app_rules = []
main = None
follow_mouse_focus = True
bring_front_click = False
cursor_warp = False
floating_layout = layout.Floating()
auto_fullscreen = True

# サンプルに書かれていたので
wmname = "LG3D"


@hook.subscribe.startup_once
def auto_start():
    home = os.path.expanduser('~')
    try:
        subprocess.call([home + '/.config/qtile/auto_start.sh'])
    except:
        pass
