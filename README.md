# bash-settings

To make rclone work, copy `rclone.conf` to `~/.config/rclone/` — this is what you need to enable the mount to Google Drive.

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
