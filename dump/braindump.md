
So I'm at it again. I just sat with Dinesh for 20 mins and talked about another crazy idea. I like the idea that a "plugin" to the repository could be written which controls how the URLs map to the underlying data. Here's what we do today.

### Today's scheme

	Base URL: http://collaborate.bt.com
	Context Path: /sdkrepo

	/assets/<TYPE>/<?BIZKEY>/<?VERSION>

This is hard baked into the java code and not easy to change. Let's say I want to write a plugin that separates a subset of model metadata into one or many universes (of discourse), then separates the model/type metadata you can view into roles (architect, developer, cleaner, etc) and I *do not* want to have to write java code to control the URL like this. How do I do it? Just for clarification, here is the URL scheme I want to implement (just by defining metadata):

	/<UNIVERSE>/<MODEL>/<ROLE>/<TYPE>
	-- example
	/governance/sdk/architect/Service

How do I *parse* this URL without special knowledge about the URL scheme? 

Tim's Crazy Ideas #1554
=======================

1. Let's assume we move the physical schema implementation onto an Object Role Modelling base, where everything is an object - type metadata, instance metadata, everything. 
2. Because of (1), the association between an object which is an Entity Type (i.e., an asset) and an object which is a Value Type (i.e., an attribute) is the same as two Entity Types connecting to each other
3. Because of (2) the way you query associations is the same way that you query attributes **EVERYTHING IS CONNECTED IN THE SAME WAY
4. Now it's time for the REALLY BIG ASSUMPTION that I'm going to make....

<assumption-warning>

Whenever you fetch something from the repository, you always generate SQL to fetch everything that [it] is connected to, up to however many levels you want. 

</assumption-warning>

So all *FETCH* queries do essentially the same thing. The special dot operator `.` is equalivalent to `$object`

	t4@repository> FETCH @Service, $object 
	# get 'service' model, get rows matching the special $object predicate (which means $object typeof $object)

	t4@repository> FETCH $meta Service Assets $key=108
	# get 'service' model, get all the 'assets' it is connected that are identified by '108'

	t4@repository> FETCH Service Assets 108 $version 6.0.2
	# get 'service' model, get all the 'assets' it is connected that are identified by '108' and have the version 6.0.2

	t4@repository> FETCH (. typeof $model, Service Assets @sdk-maturity 2
	# get 'service' model, get all the 'assets' it is connected that have an 'sdk-maturity' value of 2

	t4@repository> FETCH Assets $name `starts with` 'Manage'
	# get all the 'assets' in the repository that have a name value that starts with 'Manage'
	 

Now let's imagine that we added some new metadata:

	(* Value Types *)
	type synonym Id = String;;
	Id is limited to regex [\d]{6};;

	(* Entity Types *)
	type Role identified by roleName of Id;; 
	
	type UniverseOfDiscourse identified by uod-Name, 
		uod-Name is of Id;;
	type synonym UOD = UniverseOfDiscourse;;
		
	(* Regular association rules *)	
	UOD `pertains to role` Role, Role `is supported by` many UOD;;
	
	(* Generic Association Rules between any $OBJECT, Role and vice versa *)
	Role has many $OBJECT, $OBJECT can `belong to` many Role;;

	(* 

Now let's apply a query that would easily map from a URL such as `/Governance/SDK/Architect/Service?sdk_level.gt=2` through a SQL generation phase:

	t4@repository> FETCH (. typeof Governance), (. typeof SDK Architect Service @sdk_level `gt` 2

The query simply pushes identifiers onto the stack and the parsing and SQL generation framework is responsible for fetching the 



a,b means a then b
a;b means a and/or b with equal precedence
a-b means a or b
a+b means a and b
a:b means b of a (or b from a) *

* where a is an entity type and b a value type, this means any a where the value b is as qualified 
* where a is an entity type and so is b, this means any a that is connected to a b as qualified

