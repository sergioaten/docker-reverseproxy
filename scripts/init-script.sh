#!/bin/bash

#Vars
path="/etc/nginx/conf.d/*.conf;"
line_uncommented="include $path"
line_commented="#include $path"
mask="${path//\//\\/}"
mask="${mask//\*/\\\*}"
file="/etc/nginx/nginx.conf"
# Check if the line exists in the file
if grep -qF "$line_uncommented" "$file"; then
    echo "Line '$line_uncommented' in file '$file' exists."

    # Check if the line is commented
    if grep -qF "$line_commented" "$file"; then
        echo "Line '$line_uncommented' in file '$file' already commented."
    else
        echo "Line '$line_uncommented' in file '$file' has been commented."
        sed -i "s/include $mask/#include $mask/g" "$file"
        sed -i "/#include $mask/a include /etc/nginx/sites-enabled/*;" "$file"        
    fi

else
    echo "The line is not present in the file."
fi

#Vars
folder="/etc/nginx/sites-enabled"
#Check if the folder exists
if [ ! -d "$folder" ]; then
    mkdir "$folder"
    echo "Folder '$folder' has been created."
else
    echo "Folder '$folder' already exists."
fi

#vars
ln_source="/etc/nginx/sites-available/default"
ln_destination="/etc/nginx/sites-enabled/default"
# Check if the symbolic link doesn't exist
if [ ! -L "$ln_destination" ]; then
    # Create the symbolic link
    ln -s "$ln_source" "$ln_destination"
    echo "Symbolic link '$ln_source' -> '$ln_destination' has been created."
else
    echo "The symbolic link '$ln_source' -> '$ln_destination' already exists."
fi

service nginx restart

#Keep container up
sleep infinity
