# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Importer.new(Sale, "db/pp-2015.csv").import
# Importer.new(Sale, "db/pp-2014.csv").import
# Importer.new(Sale, "db/pp-2013.csv").import
# Importer.new(Sale, "db/pp-2012.csv").import
# Importer.new(Sale, "db/pp-2011.csv").import
# Importer.new(Sale, "db/pp-2010.csv").import
# Importer.new(Sale, "db/pp-2009.csv").import
# Importer.new(Sale, "db/pp-2008.csv").import
# Importer.new(Sale, "db/pp-2007.csv").import
# Importer.new(Sale, "db/pp-2006.csv").import
# Importer.new(Sale, "db/pp-2005.csv").import
# Importer.new(Sale, "db/pp-2004.csv").import
# Importer.new(Sale, "db/pp-2003.csv").import
# Importer.new(Sale, "db/pp-2002.csv").import
# Importer.new(Sale, "db/pp-2001.csv").import
# Importer.new(Sale, "db/pp-2000.csv").import
# Importer.new(Sale, "db/pp-1999.csv").import
# Importer.new(Sale, "db/pp-1998.csv").import
# Importer.new(Sale, "db/pp-1997.csv").import
# Importer.new(Sale, "db/pp-1996.csv").import
# Importer.new(Sale, "db/pp-1995.csv").import
