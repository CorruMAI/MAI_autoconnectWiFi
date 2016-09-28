#!/usr/bin/env bash

##################################
##################################
###POWERED BY CORRUPTED PROJECT###
##################################
##################################

VERSION="1.0.0 Powered by Corrupted Project."
purpose_SSID="MAInet_public"
wait_time=5
save_dir=~/.scriptsByCorruptedProject/

uninstall () {
    rm -R $save_dir || {
        echo "Can't uninstall. Something go wrong."
        exit 66
    }
    echo "All trash has been deleted."
}

if [[ $# > 1 ]]; then
    echo "Too much arguments."
    exit 77
else
    command=$1
    if [[ $command == "--version" || $command == "-v" || $command == "version" || $command == "v" ]]; then
        echo $VERSION
        exit 0
    elif [[ $command == "--help" || $command == "?" || $command == "help" || $command == "h" ]]; then
        echo "Just simple script for autoconnect to $purpose_SSID"
        echo "You can use next flags:"
        echo "    i[nstall] - just add this script to cron for autostart and make ~/.scripts directory"
        echo "    u[ninstall] - uninstall this script from system"
        echo "    h[elp] - will show this message"
        echo "    v[ersion] - will show current version"
        echo -e "\nYou must know, that script use crontab and iwgetid, if those utilits didn't install on your PC it willn't work!"
        echo "Before install script save your own crontab tasks in $save_dir/oldcron, but after uninstall didn't clear current tasks."
        exit 0
    elif [[ $command == "uninstall" || $command == "u" ]]; then
        uninstall
        exit 0
    elif [[ $command == "install" || $command == "i" ]]; then
        echo "Start installing..."
        #save old cron tasks
        oldcrontask=$(crontab -l)
        if [[ $? > 1 ]]; then #check exit code for last command (crontab -l)
            echo "Crontab's task hasn't been saw. Something go wrong. [2 step]"
            uninstall
            exit 2
        fi
        #hidden dir
        ( mkdir $save_dir; cp $0 $save_dir/ ) || {
            echo "Script hasn't been installed. Something go wrong. [1 step]"
            uninstall
            exit 1
        }
        #cron again
        ( echo -e "$oldcrontask" > $save_dir/oldcron) || {
            echo "Crontab's task hasn't been saved. Something go wrong. [3 step]"
            uninstall
            exit 3
        }
        ( echo -e "$oldcrontask \nMAILTO=''\n@reboot $save_dir$0\n" | crontab - ) || {
            echo "Crontab's task hasn't been update. Something go wrong. [4 step]"
            uninstall
            exit 4
        }
        nohup $save_dir$0 0>/dev/null 1>/dev/null 2>/dev/null &
        echo "Script has been installed. Autoconnect - start!"
        exit 0
    fi
fi

while :
do
    SSID=$(iwgetid)
    case $? in

         "127" )
            echo "iwgetid didn't install. Try to download Wireless tools for Linux. Just use:"
            echo "sudo apt-get install wireless-tools"
            exit 127
         ;;

         "255" )
            echo "To start - connect to Wi-Fi network"
         ;;
         
         * )
	    if [[ $SSID =~ $purpose_SSID ]] ; then
                echo "Correct SSID."
                echo "Connecting..."
                curl "1.1.1.1/login.html?network_name=Guest+Network&username=mai&password=1930&buttonClicked=4"
            else
                echo "Another SSID"
                echo $SSID
            fi
         ;;
         
    esac
    sleep $wait_time
done
