###
collections:

nouns
--------
type value  user   example:  'thrice' 'band' 'miker34'  
                             'save this dance' 'song' 'miker34'
                             'get up'  'band'   'tony045'
                             'get up'  'song'   'chrisrulez'

relationships
---------
a type b user   example:   'user'  '#love'  'band'  'miker34'

users
---------
username pwd email created
###

Db = require('mongodb').Db
Server = require('mongodb').Server
join = require('path').join
#main = require join(__dirname, '..', 'libs', 'main')

setup = (app) ->
  console.log 'TODO: implement [ text ] #is [ all nouns ]'
  console.log 'TODO: implement [ album | song | band | artist ] #feels [ feeling ]'
  console.log 'TODO: implement [ artist | band ] #influences [ artist | band ]'
  console.log 'TODO: implement #love [ all nouns ]'
  console.log 'TODO: implement #hate [ all nouns ]'
  console.log 'TODO: implement [ artist ] #in [ band | genre ]'
  console.log 'TODO: implement [ band ] #in [ genre ]'
  console.log 'TODO: implement [ artist | band ] #performs [ song ]'
  console.log 'TODO: implement [ artist | band ] #wrote [ song ]'

module.exports = {setup}