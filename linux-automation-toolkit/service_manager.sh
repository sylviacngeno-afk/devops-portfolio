#!/bin/bash

# service_manager.sh
# Simple wrapper to check status, start, or stop a systemd service.

# Usage: ./service_manager.sh <service_name> <status|start|stop|restart>

if [ "$#" -ne 2 ]; then
    echo "Usage: $0 <service_name> <status|start|stop|restart>"
    exit 1
fi

SERVICE=$1
ACTION=$2

case "$ACTION" in
    status)
        sudo systemctl status "$SERVICE"
        ;;
    start)
        echo "Starting $SERVICE..."
        sudo systemctl start "$SERVICE"
        sudo systemctl status "$SERVICE" --no-pager
        ;;
    stop)
        echo "Stopping $SERVICE..."
        sudo systemctl stop "$SERVICE"
        sudo systemctl status "$SERVICE" --no-pager
        ;;
    restart)
        echo "Restarting $SERVICE..."
        sudo systemctl restart "$SERVICE"
        sudo systemctl status "$SERVICE" --no-pager
        ;;
    *)
        echo "Invalid action: $ACTION"
        echo "Usage: $0 <service_name> <status|start|stop|restart>"
        exit 1
        ;;
esac
