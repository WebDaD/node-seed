#!/bin/bash
#  This Script uses the seed and makes a nice starter
echo -n "Please Enter the Name for the Projekt and press [ENTER]: "
read projectName
projectSlug="$(echo -n "${projectName}" | sed -e 's/[^[:alnum:]]/-/g' \ | tr -s '-' | tr A-Z a-z)"
echo -n "Your FolderName, Repo-Name, etc will be: ${projectSlug} [ENTER]"
read nothing
echo -n "Please Enter the Port for the WebInterface of Projekt and press [ENTER]: "
read projectPort
echo -n "Please Enter the Path to an Image and press [ENTER]: "
read -e projectImage
cp $projectImage assets/images/logo.png
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
git clone http://fh-hfv-git01.hf.brnet.int/sigmundd/node-seed.git /opt/$projectSlug

echo "Git Init"
cd /opt/$projectSlug
rm -rf .git
git init

echo "Replacing Variables in Files"
ls -lR . | xargs sed -i '' "s/[[seed:projektName]]/${projectName}/g"
ls -lR . | xargs sed -i '' "s/[[seed:projektSlug]]/${projektSlug}/g"
ls -lR . | xargs sed -i '' "s/[[seed:projektPort]]/${projektPort}/g"
ls -lR . | xargs sed -i '' "s/[[seed:objectName]]/${objectName}/g"
mv controllers/objectName.js controllers/${objectName}.js
mv routes/objectName.js routes/${objectName}.js
mv tests/objectName.js tests/${objectName}.js
mv database/objectName database/${objectName}
mv doc/models/objectName.json doc/models/${objectName}.json

echo "Creating First Model"
#TODO Add name and fields for first dataset

echo "Creating Database"
#TODO [ -d /var/logs ] && echo "Directory exist" || echo "Directory does not exist"

#TODO if demoEntries > 0
echo "Creating Demo-Data"
#TODO create json files with random features

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
if hash bower 2>/dev/null; then
        echo "bower is already installed"
    else
        npm install -g --save-dev bower
    fi
if hash pm2 2>/dev/null; then
        echo "pm2 is already installed"
    else
        npm install -g --save-dev pm2
    fi
if hash mocha 2>/dev/null; then
        echo "mocha is already installed"
    else
        npm install -g --save-dev mocha
    fi
if hash standard 2>/dev/null; then
        echo "standard is already installed"
    else
        npm install -g --save-dev standard
    fi
if hash istanbul 2>/dev/null; then
        echo "istanbul is already installed"
    else
        npm install -g --save-dev istanbul
    fi
if hash markdown-html 2>/dev/null; then
        echo "markdown-html is already installed"
    else
        npm install -g --save-dev markdown-html
    fi
if hash good-mocha-html-reporter 2>/dev/null; then
        echo "good-mocha-html-reporter is already installed"
    else
        npm install -g --save-dev good-mocha-html-reporter
    fi
if hash raml2html 2>/dev/null; then
        echo "raml2html is already installed"
    else
        npm install -g --save-dev raml2html
    fi
if hash jsdoc 2>/dev/null; then
        echo "jsdoc is already installed"
    else
        npm install -g --save-dev jsdoc
    fi
if hash less 2>/dev/null; then
        echo "less is already installed"
    else
        npm install -g --save-dev less
    fi
if hash jade 2>/dev/null; then
        echo "jade is already installed"
    else
        npm install -g --save-dev jade
    fi
if hash html-minifier 2>/dev/null; then
        echo "html-minifier is already installed"
    else
        npm install -g --save-dev html-minifier
    fi
if hash uglify-js 2>/dev/null; then
        echo "uglify-js is already installed"
    else
        npm install -g --save-dev uglify-js
    fi
if hash uglifycss 2>/dev/null; then
        echo "uglifycss is already installed"
    else
        npm install -g --save-dev uglifycss
    fi
if hash imagemin-cli 2>/dev/null; then
        echo "imagemin-cli is already installed"
    else
        npm install -g --save-dev imagemin-cli
    fi

echo "Installing project node modules"
npm install

echo "Installing bower modules"
bower install

echo "Running Tests"
npm run lint
npm run test

echo "Copy Web Assets to public/"
npm run copy
npm run minify

echo "Creating Documentation"
npm run doc

echo "Starting Server"
npm start
