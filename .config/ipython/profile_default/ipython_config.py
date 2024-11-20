c.TerminalIPythonApp.display_banner = True
c.TerminalInteractiveShell.editing_mode = 'vi'
c.TerminalInteractiveShell.confirm_exit = False

# Source: https://ipython.readthedocs.io/en/stable/config/details.html#keyboard-shortcuts
def custom_return(shell):

    """This function is required by the API. It takes a reference to
    the shell, which is the same thing `get_ipython()` evaluates to.
    This function must return a function that handles each keypress
    event. That function, named `handle` here, references `shell`
    by closure."""

    def handle(event):

        """This function is called each time `Enter` is pressed,
        and takes a reference to a Prompt Toolkit event object.
        If the current input starts with a bang or modulo, then
        the input is executed, otherwise a newline is entered,
        followed by any spaces needed to auto-indent."""

        # set up a few handy references to nested items...

        buffer = event.current_buffer
        document = buffer.document
        text = document.text

        if text.startswith('!') or text.startswith('%'): # execute the input...

            buffer.accept_action.validate_and_handle(event.cli, buffer)

        else: # insert a newline with auto-indentation...

            if document.line_count > 1: text = text[:document.cursor_position]
            indent = shell.check_complete(text)[1]
            buffer.insert_text('\n' + indent)

            # if you just wanted a plain newline without any indentation, you
            # could use `buffer.insert_text('\n')` instead of the lines above

    return handle

c.TerminalInteractiveShell.handle_return = custom_return
