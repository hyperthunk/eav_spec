#!/usr/bin/env ruby

require 'rubygems'
require 'terminal-table/import'

allowed_md_table = table do |t|
   t.headings = 'Object Type', 'Allowed'
   t << ['Asset Type',  'true']
   t << ['Attribute Type',  'true']
   t << ['Association Type',  'true']   
   t << ['Algebraic Data Type',  'true']   
   t << ['Asset Type',  'true']
 end
puts allowed_md_table

tt = table do |t|
  t.headings = 'Data Type', 'Mandatory', 'Description'
  t << ['Number (Integral)', 'Yes', 'Integer']
  t << ['Number (Floating Point)', 'Yes', 'Floating point number']
  t << ['Decimal', 'No', 'High precision number']
  t << ['Date', 'Yes', 'date (and optional timestamp)']
  t << ['Time', 'No', 'time stamp']
  t << ['Boolean', 'Yes', 'Boolean values (True or False']
  t << ['Character String', 'Yes', 'character data']
  t << ['Document', 'Yes', 'large character data']
end

puts tt

topp = table do |t|
  t.headings = 'Data Type', 'Operations'
  t << ['Number (Integral)', '`eq` (=), `gt` (>), `lt` (<), `gteq` (>=), `lteq` (<=), `in range`']
  t << ['Number (Float)', '`eq` (=), `gt` (>), `lt` (<), `gteq` (>=), `lteq` (<=), `in range`']
  t << ['Decimal (Integral)', '`eq` (=), `gt` (>), `lt` (<), `gteq` (>=), `lteq` (<=), `in range`']
  t << ['Date', '`eq` (=), `before` (>), `after` (<), `in range`']
  t << ['Time', '`eq` (=), `before` (>), `after` (<), `in range`']
  t << ['Boolean', '`eq` (=), `not`']
  t << ['Character String', '`eq` (=), `contains`, `starts with`, `ends with`']
end

puts topp

optop = table do |t|
  t.headings = 'Data Type', 'Optional Operations'
  t << ['Character String', '`matches` (=~)']
  t << ['Document', '`contains`']
  t << ['XML', '`path exists`']
end

puts optop

foop = table do |t|
  t.headings = 'Data Type', 'Operation', 'Description'
  t << ['Document', '`contains`']
  t << ['XML', '`path exists`']
end

assoct = table do |t|
  t.headings = 'Attribute', 'Mandatory', 'Description'
  t << ['name', 'true', 'the identifying attribute for the type']
  t << ['provider', 'true', 'a reference to an asset type node']
  t << ['consumer', 'true', 'a reference to an asset type node']
  t << ['forwardRelationshipName', 'false', 'the name describing the forward relation from provider to consumer']
  t << ['reverseRelationshipName', 'false', 'the name describing the reverse relation from consumer to provider']
end

puts assoct

card = table do |t|
  t.headings = 'Cardinality', 'Specification', 'Enforcement'
  t << ['Zero To Many', 'Mandatory', 'Consumer Assets MAY be associated with one and only one provider of the specified type'] 
  t << ['One To Many', 'Mandatory', 'Consumer Assets MUST be associated with one and only one provider of the specified type']
  t << ['Many To Many', 'Mandatory', 'Provider and consumer Assets MAY be associated with any number of the opposite type']
  t << ['Many To One', 'Optional', 'Many Provider Assets MAY be associated with one and only one consumer of the specified type']
end

puts card






