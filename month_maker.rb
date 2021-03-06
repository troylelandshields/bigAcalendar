require 'RMagick'
require_relative 'date_maker.rb'
require_relative 'weekday_maker.rb'
include Magick

$weekDayFont = "font/Helv/Helvetica-Bold.ttf"

def test!
	monthMaker = MonthMaker.new #NEED TO CHANGE ALL VARIABLES AS FUNCTION OF WIDTH
	monthMaker.font = $weekDayFont
	monthMaker.weekDayMaker.font = $weekDayFont
	monthMaker.dateCreator.font = $weekDayFont
	monthMaker.createMonth(6, 31, "MARCH", 2014).write("fonts_out/helviticas/default.png")
	#createMonthWithFonts
end

def createMonthWithFonts
	monthMaker = MonthMaker.new
	#monthMaker.createMonth(6, 31, "MARCH", 2014).write("fonts_out/Default.png")

	fonts = {
=begin	
		"SourceSansPro" => [
			"font/SourceSansPro/SourceSansPro-Bold.otf", 
			"font/SourceSansPro/SourceSansPro-Bold.otf",
			"font/SourceSansPro/SourceSansPro-Regular.otf"
		],
		"Aller" => [
			"font/Aller/Aller_Bd.ttf", 
			"font/Aller/AllerDisplay.ttf",
			"font/Aller/Aller_Rg.ttf"
		],
		"Amble" => [
			"font/Amble/Amble-Bold.ttf", 
			"font/Amble/Amble-Bold.ttf", 
			"font/Amble/Amble-Regular.ttf", 
		],
		"Cantarell" => [
			"font/Cantarell/Cantarell-Bold.ttf", 
			"font/Cantarell/Cantarell-Bold.ttf", 
			"font/Cantarell/Cantarell-Bold.ttf", 
		],
		"exo" => [
			"font/exo/Exo-Black.otf", 
			"font/exo/Exo-Black.otf", 
			"font/exo/Exo-SemiBold.otf", 
		],
		"fira-sans-mono" => [
			"font/fira-sans/FiraMonoOT-Bold.otf", 
			"font/fira-sans/FiraMonoOT-Bold.otf", 
			"font/fira-sans/FiraMonoOT-Bold.otf", 
		],
		"fira-sans" => [
			"font/fira-sans/FiraSansOT-Bold.otf", 
			"font/fira-sans/FiraSansOT-Bold.otf", 
			"font/fira-sans/FiraSansOT-Bold.otf", 
		],
		"Nobile" => [
			"font/Nobile/Nobile-Bold.ttf", 
			"font/Nobile/Nobile-Bold.ttf", 
			"font/Nobile/Nobile-Bold.ttf", 
		],
		"Quicksand" => [
			"font/Quicksand/Quicksand-Bold.otf", 
			"font/Quicksand/Quicksand-Bold.otf", 
			"font/Quicksand/Quicksand-Bold.otf", 
		],
		"Nova" => [
			"font/nova/NOVASOLID.ttf", 
			"font/nova/NOVASOLID.ttf", 
			"font/nova/NOVASOLID.ttf", 
		],
		"liberation" => [
			"font/liberation/LiberationSans-Bold.ttf", 
			"font/liberation/LiberationSans-Bold.ttf", 
			"font/liberation/LiberationSans-Bold.ttf", 
		], 
		"helvitica-HvCn" => [
			"font/HelveticaNeue/HelveticaNeueLTPro-HvCn.otf", 
			"font/HelveticaNeue/HelveticaNeueLTPro-HvCn.otf", 
			"font/HelveticaNeue/HelveticaNeueLTPro-HvCn.otf" 
		],
		"helvitica-HvEx" => [
			"font/HelveticaNeue/HelveticaNeueLTPro-HvEx.otf", 
			"font/HelveticaNeue/HelveticaNeueLTPro-HvEx.otf", 
			"font/HelveticaNeue/HelveticaNeueLTPro-HvEx.otf"
		],
		"helvitica-roman" => [
			"font/HelveticaNeue/HelveticaNeueLTStd-55-roman.otf", 
			"font/HelveticaNeue/HelveticaNeueLTStd-55-roman.otf", 
			"font/HelveticaNeue/HelveticaNeueLTStd-55-roman.otf"
		],
		"helvitica-LtEx" => [
			"font/HelveticaNeue/HelveticaNeueLTPro-LtEx.otf", 
			"font/HelveticaNeue/HelveticaNeueLTPro-LtEx.otf", 
			"font/HelveticaNeue/HelveticaNeueLTPro-LtEx.otf"
		],
		"helvitica-Lt" => [
			"font/HelveticaNeue/HelveticaNeueLTPro-Lt.otf", 
			"font/HelveticaNeue/HelveticaNeueLTPro-Lt.otf", 
			"font/HelveticaNeue/HelveticaNeueLTPro-Lt.otf" 
		],
		"helvitica-Hv" => [
			"font/HelveticaNeue/HelveticaNeueLTPro-Hv.otf", 
			"font/HelveticaNeue/HelveticaNeueLTPro-Hv.otf", 
			"font/HelveticaNeue/HelveticaNeueLTPro-Hv.otf" 
		],
=end
		"helvitica-3" => [
			"font/HelveticaNeue/helvetica-neue1.ttf",
			"font/Helv/Helvetica.ttf",  
			"font/HelveticaNeue/helvetica-neue-bold.ttf"
		],
		"helvitica-4" => [
			"font/HelveticaNeue/helvetica-neue1.ttf",
			"font/Helv/Helvetica-Bold.ttf",   
			"font/HelveticaNeue/helvetica-neue-bold.ttf"
		],
		"helvitica-5" => [
			"font/HelveticaNeue/helvetica-neue1.ttf",
			"font/Helv/Helvetica-Oblique.ttf",    
			"font/HelveticaNeue/helvetica-neue-bold.ttf"
		],
		"helvitica-6" => [
			"font/HelveticaNeue/helvetica-neue1.ttf",
			"font/Helv/Helvetica-BoldOblique.ttf",    
			"font/HelveticaNeue/helvetica-neue-bold.ttf"
		]
	}

	fonts.keys.each {|font|
		monthMaker = MonthMaker.new
		puts "Calendar with #{font}..."
		monthMaker.font = fonts[font][0]
		monthMaker.weekDayMaker.font = $weekDayFont
		monthMaker.dateCreator.font = fonts[font][2]
		monthMaker.createMonth(6, 31, "MARCH", 2014).write("fonts_out/helviticas/#{font}.png")
		puts "...finished."
	}



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
		:weekDayMaker,
		:bg_color,
		:monthDays,
		:monthNames,
		:monthDays,
		:totalWidth,
		:totalHeight,
		:addHorizontalRule,
		:addVerticalRule,
		:font,
		:baseImage
	)


	def initialize
		@dateList = nil

		@totalWidth = 14850#1500 #14850 IS DEFAULT
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
		@addVerticalRule = true

		#@font = 'font/SourceSansPro-Bold.otf'
		@dateCreator = DateCreator.new
		@weekDayMaker = WeekDayCreator.new
		@imgList = ImageList.new

		font = $weekDayFont
		weekDayMaker.font = $weekDayFont
		dateCreator.font = $weekDayFont
	end

	def createMonth(startDay, numDays, month, year)
		addAllDates(startDay, numDays, month)

	 	addDayLabels
		addDateBorders

	 	final = @imgList.flatten_images
	 	addMonthLabel(final, month, "2014")

	 	addNotesLabel(final)

	 	#return final
	 	final.write("year_out/#{month}.png")
	 	@imgList = ImageList.new
	end

	def addMonthLabel(img, month, year)
		psize = @totalHeight * 0.03666666667
		monthLbl = Draw.new
		monthLbl.gravity = NorthEastGravity
		monthLbl.pointsize = psize
		monthLbl.interword_spacing = psize/2
		monthLbl.kerning = -(psize*0.075)
		monthLbl.font = @font unless @font == nil
		monthLbl.fill = 'black'
		monthLbl.font_weight = BoldWeight

		monthLbl.annotate(img, 0, 0, @dateWidth/3, psize/4, "#{month} #{year}")
	end

	def addNotesLabel(img)
		psize = @totalHeight * 0.03666666667 * 0.7

		notes = Draw.new
		notes.gravity = NorthWestGravity
		notes.pointsize = psize
		notes.kerning = -(psize*0.075)
		notes.font = @font unless @font == nil
		notes.fill = 'black'
		notes.font_weight = BoldWeight

		notes.annotate(img, 0, 0, 300, 10100, 'NOTES:')

		
	end

	def addDayLabels
		@weekDayMaker.setSize(@dateWidth)
		#@weekDayMaker.lblHeight = @imgList[0].rows * 0.16666666

		for i in(0..6)
			weekDayLbl = @weekDayMaker.createDayLabel(i)
			weekDayLbl.page = Rectangle.new(weekDayLbl.columns, weekDayLbl.rows,
							@weekDays[i], (@weekNums[0] - (weekDayLbl.rows + (@dateDivider))))
			@imgList.push(weekDayLbl)
		end
	end

	def addAllDates(startDay, numDays, month)
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
		if(weekNum > 4)
			dateImg = @dateCreator.createDoubleDate(date-7, date, @dateDivider*0.3)
		else
			dateImg = @dateCreator.createDate(date)
		end
		
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
		@baseImage = Image.new(@totalWidth, @totalHeight){self.background_color = bg_color} if @baseImage == nil
		return @baseImage
	end

	def createDatePos(weekDay, weekNum)
		weekNum = 4 if (weekNum > 4)
		return Rectangle.new(@dateWidth, @dateHeight, @weekDays[weekDay], @weekNums[weekNum])
	end
end

test! if __FILE__==$0
