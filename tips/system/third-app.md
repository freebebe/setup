#   quick start
write message to '~/.local/share/applications/*.desktop'
    ```
    [Desktop Entry]
    Encoding=UTF-8
    Name=*
    Exec='local_address'
    Icon='with local_address PNG'
    Terminal=false
    Type=Application
    ```
    [Desktop Entry]  
    Version=1.0                                #not sure what this does
    Name=My Awesome App                        #Obviously the application name
    GenericName=Awesome App                    #Difference between this and Name?
    Comment=This app is awesome!               #The tooltip
    Exec=/path/to/sh/file/file.sh              #The command you want to execute
    Terminal=false                             #Should the app run in terminal
    Icon=/opt/PhpStorm-103.243/bin/webide.png  #The pretty picture :D
    Type=Application                           #Um?
    Categories=Network;WebBrowser;             #Categoies the app should be in
    MimeType=text/html;                        #Mime types the launcher can open
    Name[en_NZ]=My Awesome App                 #Localized version of above info
    GenericName[en_NZ]=Awesome App             #Localized version of above info
    Comment[en_NZ]=This app is awesome!        #Localized version of above infoategories=Davelopment;

