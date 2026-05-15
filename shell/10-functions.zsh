fcd() {
  local dir
  dir="$(find . -type d 2>/dev/null | fzf)" && cd "$dir"
}

tf-auth() {
  [[ -z "$TF_OP_OPS_REF" || -z "$TF_OP_DOTCOM_REF" ]] && {
    echo "tf-auth: set TF_OP_OPS_REF and TF_OP_DOTCOM_REF (see custom.zsh)" >&2
    return 1
  }
  command -v op >/dev/null || { echo "tf-auth: 1Password CLI (op) not found" >&2; return 1; }
  export TF_TOKEN_ops_gitlab_net="$(op read "$TF_OP_OPS_REF")"
  export TF_TOKEN_gitlab_com="$(op read "$TF_OP_DOTCOM_REF")"
}
