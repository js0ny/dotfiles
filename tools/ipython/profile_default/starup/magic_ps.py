from IPython.core.magic import register_line_magic

@register_line_magic
def ps(cmd):
    output = get_ipython().getoutput(f"pwsh -NoProfile -Command {cmd}")
    # If no variable is assigned to the output, print it
    if get_ipython().last_execution_result is None:
        print("\n".join(output))
    else:
        return "\n".join(output)
