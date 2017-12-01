app = angular.module "downloader.constants", []

app.constant "ICONS",
  queued: "queue"
  started: "file_download"
  finished: "done"
  error: "error"
  cancelled: "cloud_off"