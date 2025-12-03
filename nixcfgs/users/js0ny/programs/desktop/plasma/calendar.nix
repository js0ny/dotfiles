{lib, ...}: {
  xdg.configFile = {
    "plasma_calendar_alternatecalendar".text = lib.generators.toINI {} {
      General = {
        calendarSystem = "Chinese";
        dateOffset = 0;
      };
    };
    "plasma_calendar_holiday_regions".text = lib.generators.toINI {} {
      General = {
        selectedRegions = "cn_zh-cn,gb-sct_en-gb,hk_zh-cn,gb-eaw_en-gb";
      };
    };
  };
}
