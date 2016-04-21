# Node-Seed

A seed to start node-Apps with Angular FrontEnd and a File-Bases in-Memory Database

## Usage
`wget -O -  http://fh-hfv-git01.hf.brnet.int/sigmundd/node-seed/blob/master/plant.sh | bash`

or see [Manual Planting](#manual)

## Contents
### Database
->IMFB (in-memory-file-based)
Generic-Controller (load onstart from files, serve data, save to files), Database-Folder (inApp), Model (json for objects)

### Server

### FrontEnd

## Manual
Instructions to create a project from seed by hand.

### How To Plant a Seed

### How To Add Bower modules

### How To Add node modules


---
Remove below this line
# TODO:


## plant
* create models
* create database
* create repo
* create demoData
* ask for name
* ask for email
* ask for Logo
* ask for color main
* ask for compColor
* calc color 3 and 4 (3 = main font, whit on dark, black on light, 4 = active color similar fpr comColor)

## readme
* List all commands from plant here, allowing for custom usage
* List scripts from package for manual calls
* List Links


## package.json
* copy
  * https://www.npmjs.com/package/html-minifier > html-minifier --help
* restart
* https://github.com/RealFaviconGenerator/cli-real-favicon
* stop (also stop debug)
* dependencies ->reload
* publish (test && copy && lint && minify && copies node_modules, public, app.js, conf, .... to specified server in package)
## files
* raml
* create new readme.md (mv this to seed.md)
* Assets
  * html
    * index uses layout. layout has debug switch
  * css
    * spinner
  * js
    * ang
  * fonts
    * add test font
  * images
    * add node-seed logo
* app.js
  * static public/
