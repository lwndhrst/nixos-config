{ config, lib, pkgs, user, ... }:

{
  imports = 
    (import ../modules/programs) ++
    (import ../modules/services);
}
