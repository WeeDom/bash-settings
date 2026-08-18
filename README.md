# bash-settings

To make rclone work, copy `rclone.conf` to `~/.config/rclone/` — this is what you need to enable the mount to Google Drive.

---

## Neovim

`setup-new-host.sh` handles the whole thing, so on a new machine:

```bash
git clone <this repo> ~/bash-settings
cd ~/bash-settings && git submodule update --init   # vim/nvim plugins
./setup-new-host.sh
```

What it sets up:

| Thing | Where |
|---|---|
| nvim binary | `~/.local/opt/nvim-<version>/`, symlinked to `~/.local/bin/nvim` |
| config | `~/.config/nvim` → `bash-settings/nvim` |
| plugins | reused from `bash-settings/vim/` (pathogen bundles + `pack/`) |
| pynvim (python3 provider, needed by YouCompleteMe) | `~/.local/opt/nvim-venv/` |

**There is only one config.** `nvim/init.lua` adds `vim/` to the runtimepath and
then sources `vimrc`, so vim and nvim share settings, keymaps and plugins — edit
`vimrc` and both change. Anything nvim-only goes at the bottom of `nvim/init.lua`.

Neovim comes from the official tarball rather than apt, because Ubuntu ships a
version several releases behind. To upgrade, bump `NVIM_VERSION` in
`setup-new-host.sh` and re-run it (it is idempotent, and old versions stay in
`~/.local/opt` so you can roll back by re-pointing the symlink).

Sanity check after install: `nvim --version` and `nvim +checkhealth`.

---

## Setting up GitHub Light Terminal Profile (GNOME Terminal)

You can import a GitHub Light colour scheme for GNOME Terminal to make it easier to visually distinguish environments (e.g. staging).

### 1. Generate a UUID for the new profile
```bash
uuid=$(uuidgen)
echo $uuid
```
Save this value — you’ll use it in the following steps.

### 2. Create the profile list (if none exists yet)
```bash
dconf write /org/gnome/terminal/legacy/profiles:/list "['$uuid']"
```

If a list already exists, append your new UUID manually:
```bash
dconf read /org/gnome/terminal/legacy/profiles:/list
```
Update it so it looks like:
```bash
['existing-uuid', 'new-uuid']
```

Then write it back:
```bash
dconf write /org/gnome/terminal/legacy/profiles:/list "['existing-uuid', '$uuid']"
```

### 3. Set the profile’s visible name
```bash
dconf write /org/gnome/terminal/legacy/profiles:/:$uuid/visible-name "'GitHub Light'"
```

### 4. Load the colour scheme
Make sure you have `github-light.dconf` in your current directory, then run:
```bash
dconf load /org/gnome/terminal/legacy/profiles:/:$uuid/ < github-light.dconf
```

### 5. Switch profile
Open GNOME Terminal → Preferences → select **GitHub Light**. You can set it as default or switch manually when connecting to staging.

---

This will give you a terminal with a pure white background and GitHub-inspired colours, which works well with tmux’s staging overrides.
