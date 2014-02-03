require 'RMagick'
include Magick

def test!
	dateCreator = DateCreator.new
	dateCreator.createDateLabel("28")
	dateCreator.createDateLabel(10)
	dateCreator.createDateLabel(4)
end


class DateCreator

	attr_accessor(
		:lbl_size,
		:date_position,
		:black_stroke,
		:white_stroke,
		:date_color,
		:bg_color,
		:date_lbl_bg_color,
		:date_width,
		:date_height,
		:date_lbl_bg,
		:date_lbl_pos,
		:base,
		:font,
		:dateCache
	)

	def initialize
		@date_width = 2040				#Width of date box; Default = 2040
		@date_height = 1443				#Default = 1443
		@lbl_size = 200					#Size of date Default = 350
		@date_position = 80				#Position of date from upper-left corner Default = 80
		@date_color = 'white'	
		@bg_color = 'white'
		@date_lbl_bg_color = 'black'	#Height of date box
		@date_lbl_bg = nil				#BG image for the date label
		@date_lbl_pos = nil				#A rectangle to place the date
		@base = nil
		#@font = 'font/SourceSansPro-Regular.otf'
		@dateCache = []
	end

	def setSize(width)
		@date_width = width
		@date_height = @date_width * 0.70735294117647
		@lbl_size = @date_height * 0.25#0.2772002772
		@date_position = @date_width * 0.08 #0.05921568627451
		@black_stroke = @date_width * 0.01078431372549
		@white_stroke = @date_width * 0.00588235294118
	end

	def createDateAnnotation
		annotate = Draw.new
		annotate.gravity = CenterGravity
		annotate.font = @font unless @font == nil
		annotate.pointsize = @lbl_size * 0.55#(@date_height * 0.09009009009)
		annotate.kerning = -@lbl_size * 0.06 #Make this scale
		annotate.fill = @date_color.to_s
		return annotate
	end

	def createDate(date)
		return @dateCache[date] unless @dateCache[date] == nil
		createBaseImage if @base == nil
		createDateLabelBg if @date_lbl_bg == nil
		createDateLabelPos if @date_lbl_pos == nil
		temp = @date_lbl_bg.copy

		date_lbl = createDateAnnotation
		metric = date_lbl.get_type_metrics(temp, date.to_s)

		date_lbl.annotate(temp, 0, 0, metric.width*0.03, -metric.descent * 0.35, date.to_s)

		temp.page = @date_lbl_pos

		ilist = ImageList.new
		ilist.push(@base)
		ilist.push(temp)
		date_img=ilist.flatten_images
		@dateCache[date] = date_img

		#date_img.write("date#{date}.png") We don't need to save this image 
	end

	def createDoubleDate(date, date2, divider)
		createBaseImage if @base == nil
		createDateLabelBg if @date_lbl_bg == nil
		createDateLabelPos if @date_lbl_pos == nil
		temp = @date_lbl_bg.copy
		temp2 = @date_lbl_bg.copy

		date_lbl = createDateAnnotation

		metric1 = date_lbl.get_type_metrics(temp, date.to_s)
		metric2 = date_lbl.get_type_metrics(temp2, date2.to_s)

		date_lbl.annotate(temp,0, 0, metric1.width*0.03, -metric1.descent * 0.35, date.to_s)
		date_lbl.annotate(temp2, 0, 0, metric2.width*0.03, -metric2.descent * 0.35, date2.to_s)

		x = 11
		l = Draw.new
		l.stroke('black')
		l.stroke_width(divider)
		l.line(@base.columns/x, @base.rows/x, (@base.columns*(x-1)/x), (@base.rows*(x-1))/x)
		l.draw(@base)

		temp.page = @date_lbl_pos
		temp2.page = Rectangle.new(@date_lbl_bg.rows, @date_lbl_bg.columns, @date_position, @base.rows - (@date_position+@date_lbl_bg.rows))

		ilist = ImageList.new
		ilist.push(@base)
		ilist.push(temp)
		ilist.push(temp2)
		date_img=ilist.flatten_images
	end

	def createDateLabelBg 
		@date_lbl_bg = Image.new(@lbl_size, @lbl_size){self.background_color = 'transparent'}

		cir = Draw.new #This is the bigger, all-black circle.
		cir.fill = @date_lbl_bg_color.to_s
		cir.circle(@date_lbl_bg.rows/2, @date_lbl_bg.columns/2, 1, @date_lbl_bg.columns/2)
		cir.draw(@date_lbl_bg)

		cir = Draw.new
		cir.fill=@date_lbl_bg_color.to_s
		cir.stroke(@date_color.to_s)
		cir.stroke_width(@white_stroke) #This is the width of the white stroke on the inner black circle.
		cir.circle(@date_lbl_bg.rows/2, @date_lbl_bg.columns/2, @black_stroke, @date_lbl_bg.columns/2) #The size of this smaller circle determines the stroke of black that surrounds the white
		cir.draw(@date_lbl_bg)
	end

	def createDateLabelPos
		@date_lbl_pos = Rectangle.new(@date_lbl_bg.rows, @date_lbl_bg.columns, #These are actually switched, but it's square
						@base.columns-(@date_position+@date_lbl_bg.columns), @date_position)
	end

	def createBaseImage
		bg_color = @bg_color
		@base = Image.new(@date_width, @date_height){self.background_color = bg_color}
	end
end

test! if __FILE__==$0
