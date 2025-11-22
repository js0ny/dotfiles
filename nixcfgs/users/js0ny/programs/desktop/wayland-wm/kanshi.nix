{...}: let
  g14-internal = "Samsung Display Corp. ATNA40CU05-0  Unknown";
  lg4k60 = "LG Electronics LG HDR 4K 0x0004DC58";
in {
  services.kanshi = {
    enable = true;
    settings = [
      # Outputs
      {
        output = {
          criteria = g14-internal;
          alias = "g14-internal";
          mode = "2880x1800@120";
          scale = 1.5;
        };
      }
      {
        output = {
          criteria = lg4k60;
          alias = "lg4k60";
          mode = "3840x2160@59.997";
          scale = 1.6666;
        };
      }
      # Profiles
      {
        profile.name = "laptop";
        profile.outputs = [
          {
            criteria = g14-internal;
            status = "enable";
          }
        ];
      }
      {
        profile.name = "docked";
        profile.outputs = [
          {
            criteria = g14-internal;
            status = "disable";
          }
          {
            criteria = lg4k60;
            status = "enable";
          }
        ];
      }
    ];
  };
}
