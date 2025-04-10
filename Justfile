# set shell := ["fish", "-c"]
set shell := ["bash", "-c"]
set windows-shell := ["pwsh", "-c"]

import '.just.d/vars.just'
import '.just.d/cmds.just'
import '.just.d/common.just'
import '.just.d/tools.just'
import '.just.d/misc.just'
import '.just.d/linux.just'
import '.just.d/check.just'

_default:
    @just test
    @just --list
