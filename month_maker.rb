require 'RMagick'
require_relative 'date_maker.rb'
require_relative 'weekday_maker.rb'
include Magick

def test!
	monthMaker = MonthMaker.new #NEED TO CHANGE ALL VARIABLES AS FUNCTION OF WIDTH
	monthMaker.createMonth(6, 28, "FEBRUARY", 2014)
end

#First one starts at 106,2440

class MonthMaker

	attr_accessor(
		:imgList,
		:dateDivider,
		:dateWidth,
		:dateHeight,
		:weekDays,
		:weekNums,
		:dateCreator,
		:bg_color,
		:monthDays,
		:monthNames,
		:monthDays,
		:totalWidth,
		:totalHeight,
		:addHorizontalRule,
		:addVerticalRule
	)


	def initialize
		@dateList = nil

		@totalWidth = 1500 #14850 IS DEFAULT
		@totalHeight = @totalWidth * 0.72727272727273

		@dateDivider = @totalWidth * 0.0040404040404
		@dateWidth = @totalWidth * 0.13737374
		@dateHeight = @totalHeight * 0.13361111

		@bg_color = 'white'

		sundayX = @totalWidth * 0.00713804713805
		mondayX = sundayX + @dateWidth + @dateDivider #calculates to 2206 with the default values
		tuesdayX = mondayX + @dateWidth + @dateDivider
		wednesdayX = tuesdayX + @dateWidth + @dateDivider
		thursdayX = wednesdayX + @dateWidth + @dateDivider
		fridayX = thursdayX + @dateWidth + @dateDivider
		saturdayX = fridayX + @dateWidth + @dateDivider

		week1Y = @totalHeight * 0.22592592592593
		week2Y = week1Y + @dateHeight + @dateDivider
		week3Y = week2Y + @dateHeight + @dateDivider
		week4Y = week3Y + @dateHeight + @dateDivider
		week5Y = week4Y + @dateHeight + @dateDivider

		@weekDays = [sundayX, mondayX, tuesdayX, wednesdayX, thursdayX, fridayX, saturdayX]
		@weekNums = [week1Y, week2Y, week3Y, week4Y, week5Y]

		@addHorizontalRule = true
		@addVerticalRule = false

		@imgList = ImageList.new
	end

	def createMonth(startDay, numDays, month, year)
		addAllDates(startDay, numDays, month)

		addDateBorders
	 	addDayLabels

	 	final = @imgList.flatten_images
	 	addMonthLabel(final, month, "2014")
	 	final.write("#{month}.png")
	end

	def addMonthLabel(img, month, year)
		psize = @totalHeight * 0.05555555555556
		monthLbl = Draw.new
		monthLbl.gravity = NorthEastGravity
		monthLbl.pointsize = psize
		monthLbl.fill = 'black'
		monthLbl.font_weight = BoldWeight

		monthLbl.annotate(img, 0, 0, @dateWidth/3, psize/4, "#{month} #{year}")
	end

	def addDayLabels
		weekDayMaker = WeekDayCreator.new
		weekDayMaker.setSize(@dateWidth)
		#weekDayMaker.lblHeight = @imgList[0].rows * 0.16666666

		for i in(0..6)
			weekDayLbl = weekDayMaker.createDayLabel(i)
			weekDayLbl.page = Rectangle.new(weekDayLbl.columns, weekDayLbl.rows,
							@weekDays[i], (@weekNums[0] - (weekDayLbl.rows + @dateDivider)))
			@imgList.push(weekDayLbl)
		end
	end

	def addAllDates(startDay, numDays, month)
		@dateCreator = DateCreator.new
		@dateCreator.setSize(@dateWidth)

	 	@imgList.push(createBaseImage)

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

		@imgList.push(dateImg)
	end

	def addDateBorders
		horizontalRule = Image.new(@imgList[0].columns - (@totalWidth * 0.01010101010101), @dateDivider){self.background_color='black'} #TODO: Make this more dynamic
		verticalRule = Image.new(@dateDivider, (@dateHeight*5) + (@dateDivider*6)){self.background_color='black'}

		addHorizontalRules(horizontalRule) unless addHorizontalRule == false
		addVerticalRules(verticalRule) unless addVerticalRule == false
	end

	def addHorizontalRules(horizontalRule)
		currentY = @weekNums[0] - @dateDivider

		for i in 0..5
			div = horizontalRule.clone
			div.page = Rectangle.new(div.rows, div.columns, (@imgList[0].columns - div.columns)/2, currentY)

			@imgList.push(div)
			currentY = currentY + @dateHeight + @dateDivider
		end
	end

	def addVerticalRules(verticalRule)
		currentX = @weekDays[0] + @dateWidth

		for i in 0..5
			div = verticalRule.clone
			div.page = Rectangle.new(div.rows, div.columns, currentX, @weekNums[0] - @dateDivider)

			@imgList.push(div)
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
		return Image.new(@totalWidth, @totalHeight){self.background_color = bg_color}
	end

	def createDatePos(weekDay, weekNum)
		return Rectangle.new(@dateWidth, @dateHeight, @weekDays[weekDay], @weekNums[weekNum])
	end
end

test! if __FILE__==$0
