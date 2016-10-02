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
        echo "Can't be uninstalled. Something went wrong."
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
        echo "Just a simple script that autoconnects to $purpose_SSID"
        echo "You can use next flags:"
        echo "    i[nstall] - adds this script to cron for autostart and make $save_dir directory"
        echo "    u[ninstall] - uninstalls this script from the system"
        echo "    h[elp] - shows this message"
        echo "    v[ersion] - shows current version"
        echo -e "\nThis script use crontab and iwgetid. If those utilites aren't installed on your PC script won't work!"
        echo "Before script installs itself, it saves your own crontab tasks in $save_dir/oldcron. Warning! After the deinstallation settings won't be deleted!"
        exit 0
    elif [[ $command == "uninstall" || $command == "u" ]]; then
        uninstall
        exit 0
    elif [[ $command == "install" || $command == "i" ]]; then
        echo "Start installing..."
        chmod +x $0
        #save old cron tasks
        oldcrontask=$(crontab -l)
        if [[ $? > 1 ]]; then #check exit code for last command (crontab -l)
            echo "Crontab's task hasn't been shown. Something went wrong. [2 step]"
            uninstall
            exit 2
        fi
        #hidden dir
        ( mkdir $save_dir; cp $0 $save_dir/ ) || {
            echo "Script hasn't been installed. Something went wrong. [1 step]"
            uninstall
            exit 1
        }
        #cron again
        ( echo -e "$oldcrontask" > $save_dir/oldcron) || {
            echo "Crontab's task hasn't been saved. Something went wrong. [3 step]"
            uninstall
            exit 3
        }
        ( echo -e "$oldcrontask \nMAILTO=''\n@reboot $save_dir$0 > /dev/null\n" | crontab - ) || {
            echo "Crontab's task hasn't been updated. Something went wrong. [4 step]"
            uninstall
            exit 4
        }
        nohup $save_dir$0 0>/dev/null 1>/dev/null 2>/dev/null &
        echo "Script has been installed. Autoconnect start!"
        exit 0
    fi
fi

while :
do
    SSID=$(iwgetid)
    case $? in

         "127" )
            echo "iwgetid hasn't been installed. Try to download Wireless tools for Linux. Just use:"
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
                curl "1.1.1.1/login.html?network_name=Guest+Network&username=mai&password=1930&buttonClicked=4" > /dev/null
		echo "Request has been sent."
            else
                echo "Another SSID"
                echo $SSID
            fi
         ;;
         
    esac
    sleep $wait_time
done
