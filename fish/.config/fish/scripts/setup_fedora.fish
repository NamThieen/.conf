#!/usr/bin/fish
echo "Starting Fedora system setup script..."

# --- Helper function for error checking ---
function check_status
    if not test $status -eq 0
        echo "Error: Last command failed. Exiting."
        exit 1
    end
end

# ---  Add Terra repository ---
echo "---  Adding Terra repository ---"
echo "Installing Terra release package..."
sudo dnf install -y --nogpgcheck --repofrompath 'terra,https://repos.fyralabs.com/terra$releasever' terra-release >/dev/null || true
check_status
echo "Terra repository added."

# ---  Disable NetworkManager-wait-online.service ---
echo "---  Disabling NetworkManager-wait-online.service ---"
sudo systemctl disable NetworkManager-wait-online.service
check_status
echo "NetworkManager-wait-online.service disabled."

