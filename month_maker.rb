require 'RMagick'
require 'matrix'
require '/Users/troyshields/Documents/Ruby/calendar/date_maker.rb'
require '/Users/troyshields/Documents/Ruby/calendar/weekday_maker.rb'
include Magick

def test!
	monthMaker = MonthMaker.new
	monthMaker.addAllDates(1, 1)
end

#First one starts at 106,2440

class MonthMaker

	attr_accessor
		:dateImgList
		:dateDivider
		:dateWidth
		:dateHeight
		:weekDays
		:weekNums
		:dateCreator
		:bg_color
		:monthDays

	def initialize
		@dateList = nil
		@dateDivider = 60
		@dateWidth = 2040
		@dateHeight = 1443
		@bg_color = 'white'

		sundayX = 106
		mondayX = sundayX + @dateWidth + @dateDivider #calculates to 2206 with the default values
		tuesdayX = mondayX + @dateWidth + @dateDivider
		wednesdayX = tuesdayX + @dateWidth + @dateDivider
		thursdayX = wednesdayX + @dateWidth + @dateDivider
		fridayX = thursdayX + @dateWidth + @dateDivider
		saturdayX = fridayX + @dateWidth + @dateDivider

		week1Y = 2440
		week2Y = week1Y + @dateHeight + @dateDivider
		week3Y = week2Y + @dateHeight + @dateDivider
		week4Y = week3Y + @dateHeight + @dateDivider
		week5Y = week4Y + @dateHeight + @dateDivider

		@weekDays = [sundayX, mondayX, tuesdayX, wednesdayX, thursdayX, fridayX, saturdayX]
		@weekNums = [week1Y, week2Y, week3Y, week4Y, week5Y]

		@monthDays = 30

		@dateCreator = DateCreator.new

	end

	def addDayLabels
		weekDayMaker = WeekDayCreator.new
		for i in(0..6)
			weekDayLbl = weekDayMaker.createDayLabel(i)
			weekDayLbl.page = Rectangle.new(weekDayLbl.columns, weekDayLbl.rows,
							@weekDays[i], (@weekNums[0] - (weekDayLbl.rows + @dateDivider)))
			@dateImgList.push(weekDayLbl)
		end
	end

	def addAllDates(startDay, date)
	 	@dateImgList = ImageList.new
	 	@dateImgList.push(createBaseImage)

	 	currentDate = date
	 	currentWeekDay = startDay
	 	currentWeekNum = 0

	 	until currentDate > @monthDays
	 		addDate(currentWeekDay, currentWeekNum, currentDate)
	 		currentWeekNum = incrementWeekNum(currentWeekDay, currentWeekNum)
	 		currentWeekDay = incrementWeekDay(currentWeekDay)
	 		currentDate = currentDate + 1
	 	end

	 	addDateBorders
	 	addDayLabels

	 	@final = @dateImgList.flatten_images
	 	@final.write("final.png")
	end

	def addDate(weekDay, weekNum, date)
		dateImg = @dateCreator.createDateLabel(date)
		dateImg.page = createDatePos(weekDay, weekNum)

		@dateImgList.push(dateImg)
	end

	def addDateBorders
		horizontalRule = Image.new(@dateImgList[0].columns - 150, @dateDivider){self.background_color='black'} #TODO: Make this more dynamic
		verticalRule = Image.new(@dateDivider, (@dateHeight*5) + (@dateDivider*6)){self.background_color='black'}

		addHorizontalRules(horizontalRule)
		addVerticalRules(verticalRule)
	end

	def addHorizontalRules(horizontalRule)
		currentY = @weekNums[0] - @dateDivider

		for i in 0..5
			div = horizontalRule.clone
			div.page = Rectangle.new(div.rows, div.columns, (@dateImgList[0].columns - div.columns)/2, currentY)

			@dateImgList.push(div)
			currentY = currentY + @dateHeight + @dateDivider
		end
	end

	def addVerticalRules(verticalRule)
		currentX = @weekDays[0] + @dateWidth

		for i in 0..5
			div = verticalRule.clone
			div.page = Rectangle.new(div.rows, div.columns, currentX, @weekNums[0] - @dateDivider)

			@dateImgList.push(div)
			currentX = currentX + @dateWidth + @dateDivider
		end
	end

	def incrementWeekNum(currentWeekDay, currentWeekNum)
		if(currentWeekDay == 6)
			return currentWeekNum + 1
		else
			return currentWeekNum
		end
	end

	def incrementWeekDay(currentWeekDay)
		if(currentWeekDay == 6)
			return 0
		else
			return currentWeekDay + 1
		end
	end

	def createBaseImage
		bg_color = @bg_color
		return Image.new(14850, 10800){self.background_color = bg_color}
	end

	def createDatePos(weekDay, weekNum)
		return Rectangle.new(@dateWidth, @dateHeight, @weekDays[weekDay], @weekNums[weekNum])
	end
end

test! if __FILE__==$0
