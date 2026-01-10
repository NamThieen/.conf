#!/usr/bin/fish
echo "Starting Fedora system setup script..."

# --- Helper function for error checking ---
function check_status
    if not test $status -eq 0
        echo "Error: Last command failed. Exiting."
        exit 1
    end
end

# ---  Remove GNOME Software autostart ---
echo "---  Removing GNOME Software autostart entry ---"
sudre gnome-software
# ---  Flatpak Configuration ---
echo "---  Configuring Flatpak remotes ---"
echo "Removing default Fedora Flatpak remote (if it exists)..."
sudo flatpak remote-delete fedora 2 >/dev/null || true
echo "Adding Flathub remote..."./
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
check_status
echo "Flathub remote added."

# ---  Add Terra repository ---
echo "---  Adding Terra repository ---"
echo "Installing Terra release package..."
sudo dnf install -y --nogpgcheck --repofrompath 'terra,https://repos.fyralabs.com/terra$releasever' terra-release >/dev/null || true
check_status
echo "Terra repository added."

# ---  Update Flatpak appstream ---
echo "---  Updating Flatpak appstream data ---"
sudo flatpak update --appstream
sudo flatpak install warehouse bazaarq
check_status
echo "Flatpak appstream updated."

# ---  Disable NetworkManager-wait-online.service ---
echo "---  Disabling NetworkManager-wait-online.service ---"
sudo systemctl disable NetworkManager-wait-online.service
check_status
echo "NetworkManager-wait-online.service disabled."

# ---  Install Valent and Valent GNOME Shell Extension ---
echo "---  Installing Valent ---"
echo "Installing Valent via Flatpak..."
sudo flatpak install -y https://valent.andyholmes.ca/valent.flatpakref
check_status
echo "Valent has been installed."

# --- Restore extensions ---
echo "---  Restoring extensions"
sudo sudo ~/.conf/extensions/backup.sh restore ~/.conf/extensions/10-1backup/
check_status

# --- Install Vivaldi ---
echo "--- Installing Vivaldi"
echo "Adding repo"
sudo dnf config-manager addrepo --from-repofile=https://repo.vivaldi.com/stable/vivaldi-fedora.repo
echo "Installing"
sudo dnf -y install vivaldi-stable
