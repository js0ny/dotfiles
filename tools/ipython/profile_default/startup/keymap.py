from prompt_toolkit.key_binding import KeyBindings
from prompt_toolkit.key_binding.vi_state import InputMode
from prompt_toolkit.filters import Condition
from IPython import get_ipython

ip = get_ipython()
key_bindings = KeyBindings()

@Condition
def in_navigation_mode():
    return ip.pt_app.app.vi_state.input_mode == InputMode.NAVIGATION

# colemak keymap hnei
@key_bindings.add("n", filter=in_navigation_mode)
def _(event):
    "Move cursor down by visual line"
    event.current_buffer.auto_down(count=event.arg)

@key_bindings.add("e", filter=in_navigation_mode)
def _(event):
    "Move cursor up by visual line"
    event.current_buffer.auto_up(count=event.arg)

@key_bindings.add("i", filter=in_navigation_mode)
def _(event):
    "Move cursor right"
    event.current_buffer.cursor_right(count=event.arg)

# Insert with 'l' and 'L'
@key_bindings.add("l", filter=in_navigation_mode)
def _(event):
    "Enter insert mode (similar position to 'i' in Colemak)"
    event.app.vi_state.input_mode = InputMode.INSERT

@key_bindings.add("L", filter=in_navigation_mode)
def _(event):
    "Enter insert mode at the beginning of the line"
    event.current_buffer.cursor_position += event.current_buffer.document.get_start_of_line_position()

# Ne[k]st
@key_bindings.add("k", filter=in_navigation_mode)
def _(event):
    "Find next match"
    event.current_buffer.forward_search()

@key_bindings.add("K", filter=in_navigation_mode)
def _(event):
    "Find previous match"
    event.current_buffer.reverse_search()

# [J]ump
@key_bindings.add("j", filter=in_navigation_mode)
def _(event):
    "Move to end of next word"
    event.current_buffer.cursor_right_word()

@key_bindings.add("J", filter=in_navigation_mode)
def _(event):
    "Move to end of next word with capital E"
    event.current_buffer.cursor_right_word(end=True)

# Yank to end of line with 'Y'
@key_bindings.add("Y", filter=in_navigation_mode)
def _(event):
    "Yank to the end of the line"
    text_to_yank = event.current_buffer.document.text_after_cursor
    event.app.clipboard.set_text(text_to_yank)

ip.pt_app.key_bindings = key_bindings
