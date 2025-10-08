#!/usr/bin/fish
echo "Starting Fedora system setup script..."
echo "This script requires an active internet connection and sudo privileges."

# --- Helper function for error checking ---
function check_status
    if not test $status -eq 0
        echo "Error: Last command failed. Exiting."
        exit 1
    end
end

# --- Step 1: Remove GNOME Software autostart ---
echo "--- Step 1: Removing GNOME Software autostart entry ---"
sudre gnome-software
# --- Step 2: Flatpak Configuration ---
echo "--- Step 2: Configuring Flatpak remotes ---"
echo "Removing default Fedora Flatpak remote (if it exists)..."
sudo flatpak remote-delete fedora 2 >/dev/null || true # Suppress error if not found
echo "Adding Flathub remote..."./
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
check_status
echo "Flathub remote added."

# --- Step 3: Add Terra repository ---
echo "--- Step 3: Adding Terra repository ---"
echo "Installing Terra release package..."
sudo dnf install -y --nogpgcheck --repofrompath 'terra,https://repos.fyralabs.com/terra$releasever' terra-release >/dev/null || true
check_status
echo "Terra repository added."

# --- Step 4: Update Flatpak appstream ---
echo "--- Step 4: Updating Flatpak appstream data ---"
sudo flatpak update --appstream
check_status
echo "Flatpak appstream updated."

# --- Step 5: Theme GTK3 ---
echo "--- Step 5: Installing and setting GTK3 themes ---"
echo "Installing adw-gtk3 themes via Flatpak..."
sudo flatpak install -y flathub org.gtk.Gtk3theme.adw-gtk3 org.gtk.Gtk3theme.adw-gtk3-dark
check_status
echo "Setting GTK theme to 'adw-gtk3-dark' and color scheme to 'prefer-dark'..."
gsettings set org.gnome.desktop.interface gtk-theme adw-gtk3-dark
gsettings set org.gnome.desktop.interface color-scheme prefer-dark
check_status
echo "GTK themes applied."

# --- Step 7: Disable NetworkManager-wait-online.service ---
echo "--- Step 7: Disabling NetworkManager-wait-online.service ---"
sudo systemctl disable NetworkManager-wait-online.service
check_status
echo "NetworkManager-wait-online.service disabled."

# --- Step 9: Install Valent and Valent GNOME Shell Extension ---
echo "--- Step 9: Installing Valent ---"
echo "Installing Valent via Flatpak..."
sudo flatpak install -y https://valent.andyholmes.ca/valent.flatpakref
check_status
echo "Valent has been installed."
