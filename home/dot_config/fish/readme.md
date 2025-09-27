



## `type -q` vs `command -v`

```shell
󰈺 > time for i in (seq 1 10000)
            type -q vim
    end

    time for i in (seq 1 10000)
            command -v vim >/dev/null
    end


________________________________________________________
Executed in  545.79 millis    fish           external
   usr time  177.62 millis  174.28 millis    3.34 millis
   sys time  367.72 millis  366.16 millis    1.56 millis


________________________________________________________
Executed in  292.97 millis    fish           external
   usr time   71.23 millis   69.31 millis    1.93 millis
   sys time  215.22 millis  214.78 millis    0.44 millis
```

`command -v` is faster
