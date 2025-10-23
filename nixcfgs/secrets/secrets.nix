let
  defaultAge = "age1mcvqpg39t32ll684r4m2l8j0l9zag6endg0h6zjw8svkgdwc4pjqkk5fvj";
in {
  age.identityPaths = [
    "~/.config/age/keys.txt"
  ];
  "ts.age".publicKeys = [defaultAge];
}
