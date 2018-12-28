settings {
  statusFile = "/tmp/lsyncd.status",
  statusInterval = 10,
  nodaemon = true,
  insist = true,
  inotifyMode = "CloseWrite or Modify",
  maxProcesses = 1
}

rclone_command = "/usr/bin/rclone -v sync ^source ^target"


rclone = {
  delay = 600,
  maxProcesses = 1,
  onAttrib = rclone_command,
  onCreate = rclone_command,
  onModify = rclone_command,
  onStartup = rclone_command,
  onDelete = rclone_command,
  onMove = true
}

sync {
  rclone,
  source = "/home/{{ username }}/Documents/sync/",
  target = "gdrive:data/"
}
