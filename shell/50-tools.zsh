# mise (runtime version manager)
command -v mise >/dev/null && eval "$(mise activate zsh)"

# Google Cloud SDK (override GCLOUD_SDK to relocate)
GCLOUD_SDK="${GCLOUD_SDK:-$HOME/.local/share/google-cloud-sdk}"
[[ -f "$GCLOUD_SDK/path.zsh.inc" ]] && . "$GCLOUD_SDK/path.zsh.inc"
[[ -f "$GCLOUD_SDK/completion.zsh.inc" ]] && . "$GCLOUD_SDK/completion.zsh.inc"
