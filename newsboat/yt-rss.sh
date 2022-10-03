#!/bin/bash

#Script to get rss feed from special youtube links.
# Examples:
# 1) https://www.youtube.com/c/NumeroDiez  --> type "./yt-rss Numerodiez c" and press enter to get RSS url
# 2) https://www.youtube.com/user/simoneaversano  --> type "./yt-rss simoneaversano user" and press ENTER to get RSS url
# If the channel already have an id in the youtube url use:
# 2) https://www.youtube.com/channel/UCk8gzAOGprcGAFMWGzZ2zQw  --> type "./yt-rss UCk8gzAOGprcGAFMWGzZ2zQw channel" and press ENTER to get RSS url

GREEN=`tput setaf 2`
textreset=$(tput sgr0)

# Check that both argument are passed in tre command line

if [ -n "$1" ] && [ -n "$2" ]; then

    userName=$1
    folder=$2

    # printf "\nDownload Youtube channel HTML page and find ID:\n\n"

# Check if the 2nd argument is either "c" or "user" then use curl to save the html page in a txt file

        if [ "$folder" == "c" ]; then

            eval "curl -s https://www.youtube.com/c/$userName -o '$userName.txt'"

        elif [ "$folder" == "user" ]; then

            eval "curl -s https://www.youtube.com/user/$userName -o '$userName.txt'"

        elif [ "$folder" == "channel" ]; then

            eval "curl https://www.youtube.com/channel/$userName -o '$userName.txt'"

        else
            echo "2nd parameter needd to be either \"user\" or \"c\""

        fi

# Get youtube channel id from the file we just created. With the help of sed we search the id inside the html file.

    getId=$(sed -n 's/.*youtube.com\/channel\(.*\)/\1/p' $userName.txt| cut -c1-25)

# Remove the "/" slash from the ID

    removing_slash="${getId##*/}"

    #printf "\nYoutube channel id: \n\n$removing_slash\n\n${textreset}"

# Printing out the results

    #echo "https://www.youtube.com/channel/$removing_slash"

    # printf "Yotube channel RSS feed url:\n\n"

    url="http://www.youtube.com/feeds/videos.xml?channel_id=$removing_slash"

    printf  "${url}\n\n${textreset}"

#getRss=$(curl $url -o $userName.xml)

#getRssWget=$(wget --quiet -O $userName.xml $url)


# Check if the file we created earlier exist then porcede to delete it as we don't need it anymore.

    if [ -f "$userName.txt" ]; then

        eval "rm $userName.txt"

        #echo "Temp file removed!"

        else

        echo "Temp file not removed."

    fi

    # Print all the ID found in the html page and store them in the array

    # my_array=($(echo $removing_slash | tr ";" "\n"))

    #Print the split string
    # for i in "${my_array[@]}"
    # do
    #     echo $i
    # done

else

    echo "Need to pass 2 arguments, account name and folder witch can be \"user\" or \"c\""

fi
