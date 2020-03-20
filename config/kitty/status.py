from types import MethodType
from kitty.tab_bar import as_rgb

def main(args):
    pass

def update_wrapper(bar):
    original = bar.update
    def update(self, *data) -> None:
        original(*data)
        screen = self.screen
        status_len = sum([ s.find('|') + 3 for s in self.status_blocks])
        self.screen.draw(' '*(screen.columns - screen.cursor.x - status_len))
        for block in self.status_blocks:
            fields = block.split('|')
            text = fields[0]
            delimiter = chr(int(fields[3], 16))
            bg = int(fields[1], 16)
            self.screen.cursor.fg = screen.cursor.bg
            self.screen.cursor.bg = as_rgb(bg)
            self.screen.draw(delimiter)
            fg = int(fields[2], 16)
            self.screen.cursor.fg = as_rgb(fg)
            self.screen.draw(" " + text + " ")
        # self.screen.draw(u'\ue0d4')
        # self.screen.draw(" " + self.status_text_right + " ")
    return MethodType(update, bar)

def handle_result(args, answer, target_window_id, boss):
    # get the kitty window into which to paste answer
    m = boss.active_tab_manager
    bar = m.tab_bar
    if not hasattr(bar, 'status_blocks'):
        bar.status_text = ''
        bar.update = update_wrapper(bar)
    bar.status_blocks = args[1:]
    bar.update(m.tab_bar_data)


handle_result.no_ui = True
