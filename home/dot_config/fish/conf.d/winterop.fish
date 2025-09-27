if command -v wslpath > /dev/null
    function cdw
        cd (wslpath -u $argv)
    end
    function zw
        z (wslpath -u $argv)
    end
    alias psw="tasklist.exe"
    alias killw="taskkill.exe"
    alias winget="winget.exe"
    # https://github.com/stuartleeks/wsl-notify-send
    alias notify-send="wsl-notify-send.exe"
end
