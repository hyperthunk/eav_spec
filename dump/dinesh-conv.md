

## Today's scheme

 Base URL: http://collaborate.bt.com
 Context Path: /sdkrepo

 /assets/<TYPE>/<?BIZKEY>/<?VERSION>

## Tomorrow's Scheme

 /<MODEL>/<TYPE>/	# all objects of type

 /<MODEL>/<TYPE>/<?BIZKEY>/<?VERSION>    # just like today's system

 # if we're using *levels*

WITH level_1 AS (
 SELECT .....
 FROM .....
 WHERE /*model*/ record is identified as 'sdk'
), level_2 AS (
 SELECT .....
 FROM .....
 WHERE /*type*/ is identified as 'Service'
)
SELECT ....
FROM .....
WHERE criteria filters by '108' and 'v.1.0.2'

 /sdk/groups:sdk-governance/108

## Alternatives

 /<UNIVERSE>/<MODEL>/<ROLE>/<TYPE>

 /governance/sdk/architect/Service

  /governance/sdk/architect/Service/108/v1.0.2   # how to parse this?

URL
  
 SELECT .....
 FROM uod, models, roles, types
 WHERE uod.name = 'governance' AND 
       models.name = 'sdk' AND
       roles.name = 'architect'
       etc....

 # find all UOD assets
 # find the instance with name 'governance'
 # find all models
 # etc.....

WITH level_1 AS (
 SELECT .....
 FROM .....
 WHERE record is identified as 'governance'
), level_2 AS (
 SELECT .....
 FROM .....
 WHERE record is identified as 'sdk'
), level_3 AS (
 SELECT .....
 FROM .....
 WHERE record is identified as 'architect'
), level_4 AS (
 SELECT .....
 FROM .....
 WHERE record is identified as 'Service'
)
SELECT ......
FROM .....
WHERE criteria uses '108' and 'v1.0.2'

==========================================

bizfun-manifestations[parent::$name='MyBusinessFunction'],
    service-realisations[this::$route-id `eq` 'Blah'], etc

*[this::$name = 'bizfun-manifestations' + parent::$name='MyBusinessFunction'],
    *[this::$name `eq` 'service-realisations' + this::$route-id `eq` 'Blah']

a,b means a then b
a;b means a and/or b with equal precedence
a-b means a or b
a+b means a and b
a:b means b of a (or b from a) *

* where a is an entity type and b a value type, this means any a where the value b is as qualified 
* where a is an entity type and so is b, this means any a that is connected to a b as qualified

   groups:sdk-governance


