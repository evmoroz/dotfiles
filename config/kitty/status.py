import json
import pygit2
import re
import os
from pygit2 import Repository
from types import MethodType
from kitty.tab_bar import as_rgb
from kitty.rgb import color_as_int, to_color

class Di:
    factories = {}
    instances = {}

    def add(self, name, func):
        self.factories[name] = func

    def get(self, name):
        if name not in self.instances:
            self.instances[name] = self.factories.get(name, lambda: None)(self)
        return self.instances[name]

def debug(*val):
    print(*val, file=open("/tmp/kitty.debug", 'a'))

def main(args):
    pass

def git_repo(cwd):
    repo_path = pygit2.discover_repository(cwd)
    if repo_path is None:
        return

    return Repository(repo_path)


def update_wrapper(bar, original, di):
    def update(self, *data) -> None:
        di.instances = {}
        original(*data)
        screen = self.screen
        blocks = list(filter(lambda b: b.get("val") is not None, [
                { **block, **{ "val": di.get(block.get("val")) } }
                for block in self.status_blocks
                ]))

        status_len = sum([ len(b.get('del')) + len(b.get('val')) + 2 for b in blocks])
        self.screen.cursor.bg = as_rgb(color_as_int(self.draw_data.default_bg))
        self.screen.draw(' '*(screen.columns - screen.cursor.x - status_len))

        for block in blocks:
            bg = color_as_int(to_color(block.get('bg')))
            self.screen.cursor.fg = screen.cursor.bg
            self.screen.cursor.bg = as_rgb(bg)
            screen.draw(block.get("del"))
            fg = color_as_int(to_color(block.get("fg")))
            self.screen.cursor.fg = as_rgb(fg)
            screen.draw(" " + block.get("val") + " ")

    return MethodType(update, bar)

def handle_result(args, answer, target_window_id, boss):
    # get the kitty window into which to paste answer
    if args[1] != "refresh":
        manager = boss.window_id_map.get(target_window_id).tabref().tab_manager_ref()
        di = Di()
        di.add("active_window", lambda di: manager.tabs[manager._active_tab_idx].active_window)
        di.add("_cwd", lambda di: di.get("active_window").cwd_of_child)
        di.add("cwd", lambda di: di.get("_cwd").replace(os.getenv("HOME"), "~").replace("/", u" \ue0b1 "))
        di.add("branch", lambda di: u"\ue0a0 " + di.get("repo").head.shorthand if di.get("repo") is not None else None)
        di.add("repo", lambda di: git_repo(di.get("_cwd")))
        di.add("_stash", lambda di: di.get("repo").references.get("refs/stash") if di.get("repo") is not None else None)
        di.add("stash", lambda di: " " + str(len( list(di.get("_stash").log()))) if di.get("_stash") is not None else None)
        di.add("modified",
                lambda di: " " + str(len([
                    [x, f] for x, f in di.get("repo").status().items()
                    if f not in [
                        pygit2.GIT_STATUS_CURRENT,
                        pygit2.GIT_STATUS_IGNORED
                        ]
                    ])) if di.get("repo") is not None else None)
        bar = manager.tab_bar
        if not hasattr(bar, 'original_update'):
            bar.status_blocks=[]
            bar.original_update=bar.update
        bar.update = update_wrapper(bar, bar.original_update, di)
        bar.status_blocks = [ { **{ "bg": "#000000", "fg": "#ffffff", "del": ">" }, **json.loads(a) } for a in args[1:] ]

    boss.window_id_map.get(target_window_id).tabref().mark_tab_bar_dirty()

handle_result.no_ui = True
