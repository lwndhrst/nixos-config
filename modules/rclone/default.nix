{ pkgs, ... }:

{
  home.packages = with pkgs; [
    rclone
  ];

  # Assumption:
  # - rclone remote has been configured via cli
  # - /mnt/gdrive exists and user has access
  systemd.user.services.rclone-gdrive-mount = {
    Unit = {
      Description = "Rclone config for mounting Google Drive.";
      After = [ "network-online.target" ];
    };
    Service = {
      Type = "notify";
      ExecStart = "${pkgs.rclone}/bin/rclone mount gdrive:/ /mnt/gdrive --vfs-cache-mode full";
      ExecStop="/run/current-system/sw/bin/fusermount -u /mnt/gdrive";
      Restart = "on-failure";
      RestartSec = "10s";
    };
    Install.WantedBy = [ "default.target" ];
  };
}
