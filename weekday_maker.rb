require 'RMagick'
include Magick

def test!
	dayCreator = WeekDayCreator.new
	dayCreator.createDayLabel(1)
end


class WeekDayCreator

	attr_accessor(
		:weekLabels,
		:lblWidth,
		:lblHeight,
		:dayColor,
		:bgColor,
		:font,
		:base #The template base
	)

	def initialize
		@weekLabels = ["S", "M", "T", "W", "T", "F", "S"]
		@weekLblColors = ["maroon", "black", "black", "black", "black", "black", "maroon"]
		@lblWidth = 2040 #Date width
		@lblHeight = 1800 #Height from top
		@bgColor = 'white'
		#@font = 'font/SourceSansPro-Bold.otf'
		@base = nil
	end

	def setSize(width)
		@lblWidth = width
		@lblHeight = @lblWidth * 0.88235294117647
	end

	def createDayLabel(day)
		createBaseImage if @base == nil
		temp = @base.copy

		dayLbl = Draw.new
		dayLbl.gravity = CenterGravity #Maybe change this
		dayLbl.pointsize = @lblHeight #+ (@lblHeight * (1.0/7.0))
		dayLbl.fill = @weekLblColors[day]
		dayLbl.font = @font unless @font == nil
		dayLbl.font_style = ObliqueStyle
		dayLbl.font_weight = BoldWeight
		dayLbl.annotate(temp, 0, 0, 0, 0, @weekLabels[day])

		#temp.write("day.png") # We don't need to save this image 
		return temp
	end

	def createBaseImage
		bgColor = @bgColor
		@base = Image.new(@lblWidth, @lblHeight){self.background_color = bgColor}
	end
end

test! if __FILE__==$0
