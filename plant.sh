#!/bin/bash
#  This Script uses the seed and makes a nice starter
echo -n "Please Enter the Name for the Projekt and press [ENTER]: "
read projectName
projectSlug="$(echo -n "${projectName}" | sed -e 's/[^[:alnum:]]/-/g' \ | tr -s '-' | tr A-Z a-z)"
echo -n "Your FolderName, Repo-Name, etc will be: ${projectSlug} [ENTER]"
read nothing
echo -n "Please Enter the Port for the WebInterface of Projekt and press [ENTER]: "
read projectPort
echo -n "Please Enter Name for starting Object (e.g. user) and press [ENTER]: "
read objectName
echo -n "Please Enter commaseperated Fields starting Object (e.g. id,name,mail) and press [ENTER]: "
read objectProperties
read -r -p "Do you want to create some Demo Data? [y/N] " response_demodata
case $response_demodata in
    [yY][eE][sS]|[yY])
        read -r -p "Please Enter number of entries: " demoEntries
        ;;
    *)
        echo "Skipping Demo Data"
        ;;
esac
read -r -p "Do you want to create an online repo on gitlab server? [y/N] " response_repo

echo "Installing Prerequistes"
if hash git 2>/dev/null; then
        echo "git is already installed"
    else
        apt-get install -y git
    fi
if hash node 2>/dev/null; then
        echo "node is already installed"
    else
        apt-get install -y nodejs && ln -s /usr/bin/nodejs /usr/bin/node
    fi
if hash npm 2>/dev/null; then
        echo "npm is already installed"
    else
        apt-get install -y npm
    fi

echo "Cloning Seed"
git clone http://fh-hfv-git01.hf.brnet.int/sigmundd/node-seed.git /opt/$projectName

echo "Git Init"
cd /opt/$projectName
rm -rf .git
git init

echo "Replacing Variables in Files"
#TODO http://stackoverflow.com/questions/15230865/replace-a-string-in-all-files-unix (replace vars for name e.g. $(projectName) = )

echo "Creating First Model"
#TODO Add name and fields for first dataset

echo "Creating Database"
# [ -d /var/logs ] && echo "Directory exist" || echo "Directory does not exist"

echo "git commit"
git add .
git commit -m "Initial Commit"


case $response_repo in
    [yY][eE][sS]|[yY])
        echo "Creating Repo on git01"
        #TODO http://narkoz.github.io/gitlab/ (on git01, use ssh!)
        #TODO git set remote ...
        #TODO git push -u origin master
        ;;
    *)
        echo "Skipping Online Repo"
        ;;
esac

echo "Installing global node modules"
#TODO only if needed (if->else from above!)

echo "Installing project node modules"
npm install

echo "Installing bower modules"
bower install

echo "Copy Web Assets to public/"
npm run copy

echo "Running Tests"
npm run test

echo "Creating Documentation"
npm run doc

echo "Starting Server"
npm start
