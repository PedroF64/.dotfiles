#!/bin/bash

# Check if Spotube is running
if pgrep -x "spotube" > /dev/null; then

    # If Spotube is playing, get metadata for the currently playing track
    metadata=$(playerctl -p Spotube metadata --format '{{artist}} - {{title}}')
    
    # Get current position and duration of the song
    #current_position=$(playerctl -p Spotube position --format '{{duration(position)}}')
    duration=$(playerctl -p Spotube metadata --format '{{duration(mpris:length)}}')

    # Limit the length of the metadata string
    max_length=40  # Adjust as needed
    truncated_metadata=$(echo "$metadata" | awk '{ print substr($0, 1, '$max_length'); }')
    
    # Append "..." if the metadata was truncated
    if [ ${#metadata} -gt $max_length ]; then
        truncated_metadata+="..."
    fi
    
    # Check if Spotube is playing
    player_status=$(playerctl -p Spotube status)

    # If Spotube is playing, get metadata for the currently playing track
    if [ "$player_status" = "Playing" ]; then
        echo "$truncated_metadata | $duration"
        exit 0
    else
        echo "$truncated_metadata | PAUSED"
        exit 0
    fi


    
fi

# Output a default message if no media is playing or Spotify is not the active player
echo ""