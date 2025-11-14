from prompt_toolkit.key_binding import KeyBindings
from prompt_toolkit.key_binding.vi_state import InputMode
from prompt_toolkit.filters import Condition
from IPython import get_ipython

ip = get_ipython()
key_bindings = KeyBindings()

@Condition
def in_navigation_mode():
    return ip.pt_app.app.vi_state.input_mode == InputMode.NAVIGATION

# Yank to end of line with 'Y'
@key_bindings.add("Y", filter=in_navigation_mode)
def _(event):
    "Yank to the end of the line"
    text_to_yank = event.current_buffer.document.text_after_cursor
    event.app.clipboard.set_text(text_to_yank)

ip.pt_app.key_bindings = key_bindings
