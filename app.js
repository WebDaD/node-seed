var moment = require('moment')
require('log-timestamp')(function () { return '[' + moment().format('YYYY-MM-DD HH:mm:ss') + ']:%s' })
