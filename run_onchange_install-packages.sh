{{ if ne .chezmoi.os "linux" }}
curl -sS https://starship.rs/install.sh | sh
{{ end }}
