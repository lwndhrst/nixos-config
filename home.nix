{ config, lib, pkgs, user, ... }:

{
  imports = 
    (import ../modules/editors) ++
    (import ../modules/programs) ++
    (import ../modules/services) ++
    (import ../modules/terminals);
}
