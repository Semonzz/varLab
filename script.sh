main(){
    clear
    echo "Lab Program!"
    while true; do
        echo "1. Current directory"
        echo "2. Change Directory"
        echo "3. Print file"
        echo "4. Edit file with echo"
        echo "5. Edit file with nano"
        echo "7. Quit"
        echo
        read -p "Choose one: " choice
        echo 
        case $choice in
            "1" ) pwd;;
            "2" ) chngDir;;
            "3" ) prntFile;;
            "4" ) editEcho;;
            "5" ) editNano;;
            "7" ) exit 0;;
            * ) echo "Smth wrong!";;
        esac
    done
}

checkPath() {
    if [ -d "$1" ]; then
        true
    else 
        false
    fi
}

checkFile() {
    if [ -f "$1" ]; then
        true
    else 
        false
    fi
}

inputPath() {
    read -e -p "Enter a directory: " path  #-e for Tab
    echo $path
}

inputFile() {
    read -e -p "Enter a file: " file  #-e for Tab
    echo $file
}

chngDir(){
    path=$(inputPath)
    if checkPath "$path"; then
        cd "$path"
        echo "Succesful!"
        echo
    else 
        echo "No such directory!"
        echo
    fi
}

prntFile() {
    file=$(inputFile)
    if checkFile "$file"; then
        less "$file"
        echo
    else 
        echo "No such File!"
        echo
    fi
}

editEcho() {
    file=$(inputFile)
    read -e -p "Enter a Text: " text

    if checkFile "$file"; then
        read -p "File exist! Overwrite(y/n)? " ow
        if [[ "$ow" != "y" ]]; then 
            echo "Rejected!"
            return
        fi
    fi

    echo "$text" > "$file" && echo "Succesful!"
}

editNano() {
    file=$(inputFile)
    nano "$file"
    echo "Succesful"
    echo
}

main