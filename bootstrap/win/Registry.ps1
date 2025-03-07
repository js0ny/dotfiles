
# Disable StickyKeys
REG ADD "HKEY_CURRENT_USER\Control Panel\Accessibility\StickyKeys" /v "Flags" /t REG_SZ /d "506" /f

# Disable Hyper+Keys to open Office apps
REG ADD HKCU\Software\Classes\ms-officeapp\Shell\Open\Command /t REG_SZ /d rundll32

# Disable DOS 8.3 file name creation
sudo fsutil 8dot3name set 1
# Delete all known DOS 8.3 file name
fsutil 8dot3name strip /s /v C:\
