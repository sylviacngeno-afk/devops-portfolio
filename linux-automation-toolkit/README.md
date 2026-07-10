# Linux Automation Toolkit

A collection of bash scripts automating common Linux system administration tasks — built and tested on an Ubuntu EC2 instance.

## Scripts

### 1. `provision_user.sh`
Automates user onboarding: creates a group (if needed), creates a user with a home directory, adds the user to the group, and sets correct ownership/permissions (`750`) on the home directory.

**Usage:**
```bash
./provision_user.sh <username> <groupname>
```

### 2. `health_check.sh`
Reports system health: top 5 processes by CPU and memory usage, disk usage, and memory usage — a quick diagnostic snapshot.

**Usage:**
```bash
./health_check.sh
```

### 3. `service_manager.sh`
Wraps `systemctl` to check status, start, stop, or restart a service without needing to remember exact syntax each time.

**Usage:**
```bash
./service_manager.sh <service_name> <status|start|stop|restart>
```

### 4. `backup.sh`
Creates a timestamped `.tar.gz` backup of a specified directory. Uses `sudo` internally to support backing up directories owned by other users (a realistic requirement for backup tooling).

**Usage:**
```bash
./backup.sh <directory_to_backup> <backup_destination>
```

## Key Learnings

- **Directory permissions**: Backing up another user's directory failed until the script used `sudo` — a direct example of Linux read/execute permission bits controlling directory access, even for otherwise privileged system users.
- **Absolute vs. relative paths**: All scripts are designed to accept absolute paths as arguments, avoiding the common pitfall of relative paths breaking when a script is run from a different working directory.
