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
    rofi_window = 'rofi_window'
    rofi_windowcd = 'rofi_windowcd'
    rofi_system_menu = 'rofi_system_menu'
    rofi_drun = 'rofi_drun'


wmname = 'LG3D'
mod = 'mod1'

keys = [
    # Window manager controls
    Key([mod, 'control', 'shift'], 'r', lazy.restart()),
    # Key([mod, 'control', 'shift'], 'q', lazy.shutdown()),

    # Switch window focus to other pane(s) of stack
    # 以下のkeymapはBspだと動作しない
    Key([mod], 'space', lazy.layout.next()),
    Key([mod], 'o', lazy.layout.next()),

    # Active window を Floating layout に変更
    Key([mod, 'control'], 'space', lazy.window.toggle_floating()),

    # Active window を移動
    Key([mod], 'h', lazy.layout.left()),
    Key([mod], 'j', lazy.layout.down()),
    Key([mod], 'k', lazy.layout.up()),
    Key([mod], 'l', lazy.layout.right()),

    # Windowを *入れ替える*
    #     全体のレイアウト/配置を変更せずにWindowの中身を入れ替える
    # Monadtailを使用する/共存させる
    #     layout切替時のhookで、現在のレイアウトを読んで都度keyをupdateしたほうが良さそう
    #     monadtailを使用する場合は以下に書き換えること
    #         shuffle_left() -> swap_left()
    #         shuffle_right() -> swap_right()
    #     monadtailの場合 shuffle_left() では操作を受け付けてくれない(何も起きない)
    #     bspの場合 shuffle_left() でないと操作を受け付けてくれない
    #Key([mod, 'shift'], 'h', lazy.layout.swap_left()),
    #Key([mod, 'shift'], 'l', lazy.layout.swap_right()),
    Key([mod, 'shift'], 'h', lazy.layout.shuffle_left()),
    Key([mod, 'shift'], 'j', lazy.layout.shuffle_down()),
    Key([mod, 'shift'], 'k', lazy.layout.shuffle_up()),
    Key([mod, 'shift'], 'l', lazy.layout.shuffle_right()),

    # Windowの *位置を交換*
    # サイズはそのままで、交換先が複数のWindowで構成されている場合はサイズを変更せずにまるごと位置を入れ替える
    # ex) 以下のWindowの配置で、4をActiveにした状態でflip_up()したときの挙動
    # | 1 |2|  3  |     ->      |    4      |
    # |    4      |   flip_up   | 1 |2|  3  |
    Key([mod, 'control', 'shift'], 'j', lazy.layout.flip_down()),
    Key([mod, 'control', 'shift'], 'k', lazy.layout.flip_up()),
    Key([mod, 'control', 'shift'], 'h', lazy.layout.flip_left()),
    Key([mod, 'control', 'shift'], 'l', lazy.layout.flip_right()),

    # Window size
    # Bsp Layoutでは使用しない
    #Key([mod], 'i', lazy.layout.grow()),
    #Key([mod], 'm', lazy.layout.shrink()),
    #Key([mod], 'n', lazy.layout.normalize()),
    #Key([mod], 'u', lazy.layout.maximize()),
    Key([mod, 'control'], 'j', lazy.layout.grow_down()),
    Key([mod, 'control'], 'k', lazy.layout.grow_up()),
    Key([mod, 'control'], 'h', lazy.layout.grow_left()),
    Key([mod, 'control'], 'l', lazy.layout.grow_right()),

    # 次のLayoutに変更
    Key([mod], 'Tab', lazy.next_layout()),

    # アプリケーション起動
    Key([mod], 'w', lazy.spawn(Commands.rofi_window)),
    Key([mod], 'a', lazy.spawn(Commands.rofi_system_menu)),
    Key([mod], 's', lazy.spawn(Commands.rofi_windowcd)),
    Key([mod], 'f', lazy.spawn(Commands.rofi_drun)),
    Key([mod], 'd', lazy.spawn(Commands.dmenu)),
    Key([mod], 'r', lazy.spawn(Commands.nm_dmenu)),
    Key([mod], 'Return', lazy.spawn(Commands.terminal)),

    # Window kill
    Key([mod, 'shift'], 'q', lazy.window.kill()),
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
    # layout.MonadTall(),
    layout.Bsp(
        border_focus='#0000ff', # Border colour for the focused window.
        border_normal='#000000', # Border colour for un-focused windows.
        border_width=3, # Border width.
        fair=True, # New clients are inserted in the shortest branch.
        grow_amount=10, # Amount by which to grow a window/column.
        lower_right=True, # New client occupies lower or right subspace.
        margin=3, # Margin of the layout
        name='bsp', # Name of this layout.
        ratio=1.6, # Width/height ratio that defines the partition direction.
    ),
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
            widget.TextBox(text=' Pomodoro '),
            widget.Pomodoro(),
            widget.TextBox(text=' | '),
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
