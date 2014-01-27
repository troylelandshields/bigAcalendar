require 'RMagick'
require '/Users/troyshields/Documents/Ruby/calendar/date_maker.rb'
require '/Users/troyshields/Documents/Ruby/calendar/weekday_maker.rb'
include Magick

def test!
	monthMaker = MonthMaker.new
	monthMaker.createMonth(3, 31, "JANUARY", 2014)
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
		:monthNames
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

		@dateCreator = DateCreator.new

	end

	def createMonth(startDay, numDays, month, year)
		addAllDates(startDay, numDays, month)

		addDateBorders
	 	addDayLabels

	 	final = @dateImgList.flatten_images
	 	addMonthLabel(final, month, "2014")
	 	final.write("#{month}.png")
	end

	def addMonthLabel(img, month, year)
		psize = 600
		monthLbl = Draw.new
		monthLbl.gravity = NorthEastGravity
		monthLbl.pointsize = psize
		monthLbl.fill = 'black'
		monthLbl.font_weight = BoldWeight

		monthLbl.annotate(img, 0, 0, @dateWidth/3, psize/4, "#{month} #{year}")
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

	def addAllDates(startDay, numDays, month)
	 	@dateImgList = ImageList.new
	 	@dateImgList.push(createBaseImage)

	 	currentDate = 1
	 	currentWeekDay = startDay
	 	currentWeekNum = 0

	 	until currentDate > numDays
	 		addDate(currentWeekDay, currentWeekNum, currentDate)
	 		currentWeekNum = incrementWeekNum(currentWeekDay, currentWeekNum)
	 		currentWeekDay = incrementWeekDay(currentWeekDay)
	 		currentDate = currentDate + 1
	 	end
	end

	def addDate(weekDay, weekNum, date)
		dateImg = @dateCreator.createDate(date)
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
