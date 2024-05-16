#!/bin/bash

# Check if spotify is running
if pgrep -x "spotify" > /dev/null; then

    # If spotify is playing, get metadata for the currently playing track
    metadata=$(playerctl -p spotify metadata --format '{{artist}} - {{title}}')
    
    # Get current position and duration of the song
    current_position=$(playerctl -p spotify position --format '{{duration(position)}}')
    duration=$(playerctl -p spotify metadata --format '{{duration(mpris:length)}}')

    # Limit the length of the metadata string
    max_length=30  # Adjust as needed
    truncated_metadata=$(echo "$metadata" | awk '{ print substr($0, 1, '$max_length'); }')
    
    # Append "..." if the metadata was truncated
    if [ ${#metadata} -gt $max_length ]; then
        truncated_metadata+="..."
    fi
    
    # Check if spotify is playing
    player_status=$(playerctl -p spotify status)

    # If spotify is playing, get metadata for the currently playing track
    if [ "$player_status" = "Playing" ]; then
        echo "$truncated_metadata | $current_position - $duration"
        exit 0
    else
        echo "$truncated_metadata | PAUSED"
        exit 0
    fi


    
fi

# Output a default message if no media is playing or Spotify is not the active player
echo ""