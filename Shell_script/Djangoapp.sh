#!/bin/bash

code_clone() {

        echo "clonning the app"
        git clone https://github.com/LondheShubham153/django-notes-app.git
}

isntall_requiremnt() {

        echo "installing requirement"
        sudo apt-get install docker.io -y
        sudo apt-get install nginx -y

}

required_restart() {
        sudo chown $USER /var/run/docker.sock
        sudo systemctl enable docker
        sudo systemctl enable nginx
        sudo systemctl restart docker

}


deploy() {
        docker build -t notes-app .
        docker run -d -p 8000:8000 notes-app:latest
}


echo "*********deploy started**********"
if ! code_clone; then
        echo "code already exists"
        cd django-notes-app
fi


if ! isntall_requiremnt; then
        echo "installation failed "
        exit 1
fi


if ! required_restart; then
        echo " system fault "
       exit 1
fi


if ! deploy; then
        echo "deployment failed "
        exit 1
fi


echo "****** deploy done **********"
