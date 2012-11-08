###
collections:

nouns
--------
type value  user

relationships
---------
a type b user

users
---------
username pwd email created
###

Db = require('mongodb').Db
Server = require('mongodb').Server
join = require('path').join
#main = require join(__dirname, '..', 'libs', 'main')

setup = (app) ->
  console.log 'TODO: handle all these calls :)'

module.exports = {setup}