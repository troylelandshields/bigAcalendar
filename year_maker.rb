require 'RMagick'
require_relative 'month_maker.rb'
include Magick


def test!
	yearCreator = YearCreator.new
	yearCreator.createYear(2014, 3)
end


class YearCreator

	attr_accessor(
		:months
	)

	def initialize
		@monthDays = {
			"JANUARY" => 31,
			"FEBRUARY" => 28,
			"MARCH" => 31,
			"APRIL" => 30,
			"MAY" => 31,
			"JUNE" => 30,
			"JULY" => 31,
			"AUGUST" => 31,
			"SEPTEMBER" => 30,
			"OCTOBER" => 31,
			"NOVEMBER" => 30,
			"DECEMBER" => 31
		}
	end

	def createYear(year, startDay)
		monthMaker = MonthMaker.new
		@monthDays.keys.each {|month|
			puts "Creating #{month}..."
			monthMaker.createMonth(startDay, @monthDays[month], month, 2014)
			startDay = (startDay + @monthDays[month])%7
			puts "#{month} finished."
		}

		
	end
end

test! if __FILE__==$0
