main(){
    clear
    echo "Lab Program!"
    while true; do
        echo "1. Current directory"
        echo "2. Change Directory"
        echo "3. Print file"
        echo "4. Edit file with echo"
        echo "5. Edit file with nano"
        echo "6. Directoris and files"
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
            "6" ) dirAndFiles;;
            "7" ) exit 0;;
            * ) echo "No choice!!";;
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

dirAndFiles() {
    echo
    echo "1. Create directory"
    echo "2. Remove directory"
    echo "3. Rename file or directory"
    echo "4. Create file"
    echo "5. Remove file"
    echo "6. Copy file or directory"
    echo "7. Move file or directory"
    echo 
    read -p "Choose one: " choice
    echo 
    case $choice in
        "1" ) crtDir;;
        "2" ) rmvDir;;
        "3" ) rnmDirAndFile;;
        "4" ) crtFile;;
        "5" ) rmvFile;;
        "6" ) cpyDirAndFile;;
        "7" ) mvDirAndFile;;
        * ) echo "No choice!!"
    esac
}

crtDir() {
    path=$(inputPath)
    if checkPath "$path"; then
        echo "Already exists!"
        echo
    else 
        mkdir "$path"
        echo "Succesful!"
        echo
    fi
}

rmvDir() {
    path=$(inputPath)
    if checkPath "$path"; then
        rm -r "$path"
        echo "Successful"
        echo
    else 
        echo "No such directory!"
        echo
    fi
}

inputName() {
    read -e -p "Enter a file or directory name: " name  #-e for Tab
    echo $name
}

rnmDirAndFile() {
    name=$(inputName)
    read -e -p "Enter a new name: " text

    if checkPath "$name" || checkFile "$name"; then
        mv "$name" "$text"
        echo "Successful"
        echo
    else 
        echo "No such file or directory!"
        echo
    fi
}

crtFile() {
    file=$(inputFile)
    if checkFile "$file"; then
        echo "Already exists!"
        echo
    else 
        touch "$file"
        echo "Succesful!"
        echo
    fi
}

rmvFile() {
    file=$(inputFile)
    if checkFile "$file"; then
        rm "$file"
        echo "Successful"
        echo
    else 
        echo "No such directory!"
        echo
    fi
}

cpyDirAndFile() {
    toCpy=$(inputName)
    whrCpy=$(inputPath)
    if checkFile "$toCpy"; then 
        if checkPath "$whrCpy"; then 
            cp "$toCpy" "$whrCpy"
            echo "Success!"
            echo
        else 
            echo "Destination error!"
            echo
        fi
    elif checkPath "$toCpy"; then 
        if checkPath "$whrCpy"; then 
            cp -R "$toCpy" "$whrCpy"
            echo "Success!"
            echo
        else 
            echo "Destination error!"
            echo
        fi
    else 
        echo "No such file or directory!"
        echo
    fi
}

mvDirAndFile() {
    toMv=$(inputName)
    whrMv=$(inputPath)
    if checkFile "$toMv" || checkPath "$toMv"; then 
        if checkPath "$whrMv"; then 
            mv "$toMv" "$whrMv"
            echo "Success!"
            echo
        else 
            echo "Destination error!"
            echo
        fi
    else 
        echo "No such file or directory!"
        echo
    fi
}

main