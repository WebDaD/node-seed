/**
 * @overview 	Config File for [[seed:projectName]]
 * @module config
 * @author Dominik Sigmund
 * @version 0.0.1
 * @description	Config
 * @memberof [[seed:projectSlug]]

 */

 /**
  * The Config-Object to export
  * @type {object}
  */
var config = module.exports = {}

/**
 * The Port on which we can access the web-Application
 * @type {number}
 */
config.port = '[[seed:projectPort]]'

/**
 * The  Object to keep track of versioning the API
 * @type {object}
 */
config.apiversion = {}

/**
 * The Active API (the one that should be used)
 * @type {string}
 */
config.apiversion.active = 'v1'

/**
 * The deprecated API's (can be used, but should not)
 * @type {array}
 */
config.apiversion.deprecated = []

/**
 * No Longer supported versions
 * @type {array}
 */
config.apiversion.inactive = []
