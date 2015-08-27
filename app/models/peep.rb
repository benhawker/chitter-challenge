require 'data_mapper'
require 'dm-validations'

class Peep

	include DataMapper::Resource

	property :id, Serial
	# add validations to peep content length min and max
	property :content, String, :required => true #, :min => 1 ,:length => 1..140
	property :time, Time, :required => true
	
	validates_presence_of :content, :time

	belongs_to :user

end