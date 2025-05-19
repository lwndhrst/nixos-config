{ pkgs, ... }:

{
  home.packages = with pkgs; [
    rclone
  ];

  # Assuming rclone remote has been configured via cli
  systemd.user.services.rclone-gdrive-mount = {
    Unit = {
      Description = "Rclone config for mounting Google Drive.";
      After = [ "network-online.target" ];
    };
    Service = {
      Type = "notify";
      ExecStart = "${pkgs.rclone}/bin/rclone mount \"gdrive:\" \"/mnt/gdrive\" --vfs-cache-mode full";
      ExecStop="/bin/fusermount -u /mnt/gdrive";
    };
    Install.WantedBy = [ "default.target" ];
  };
}
