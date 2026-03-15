{...}: {
  environment.etc."wireplumber/wireplumber.conf.d/51-rename-alsa-devices.conf".text = ''

    monitor.alsa.rules = [
        {
            matches = [
                {
                    node.name = "alsa_input.pci-0000_65_00.6.analog-stereo"
                }
            ]
            actions = {
                update-props = {
                    node.description = "内置麦克风"
                }
            }
        }
    ]
  '';
}
