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
		:date_color,
		:bg_color,
		:date_lbl_bg_color,
		:date_width,
		:date_height,
		:date_lbl_bg,
		:date_lbl_pos,
		:base,
		:dateCache
	)

	def initialize
		@date_width = 2040				#Width of date box; Default = 2040
		@date_height = 1443				#Default = 1443
		@lbl_size = 200					#Size of date Default = 350
		@date_position = -50				#Position of date from upper-left corner Default = 80
		@date_color = 'white'	
		@bg_color = 'white'
		@date_lbl_bg_color = 'black'	#Height of date box
		@date_lbl_bg = nil				#BG image for the date label
		@date_lbl_pos = nil				#A rectangle to place the date
		@base = nil
		@dateCache = []
	end

	def createDate(date)
		return @dateCache[date] unless @dateCache[date] == nil
		createBaseImage if @base == nil
		createDateLabelBg if @date_lbl_bg == nil
		createDateLabelPos if @date_lbl_pos == nil
		temp = @date_lbl_bg.copy

		date_lbl = Draw.new
		date_lbl.gravity = CenterGravity
		date_lbl.pointsize = @lbl_size - 90
		date_lbl.fill = @date_color.to_s
		date_lbl.annotate(temp, 0, 0, 0, 0, date.to_s)

		temp.page = @date_lbl_pos

		ilist = ImageList.new
		ilist.push(@base)
		ilist.push(temp)
		date_img=ilist.flatten_images
		@dateCache[date] = date_img

		#date_img.write("date#{date}.png") We don't need to save this image 
	end

	def createDateLabelBg 
		@date_lbl_bg = Image.new(@lbl_size+10, @lbl_size+10){self.background_color = 'transparent'}

		cir = Draw.new #This is the bigger, all-black circle.
		cir.fill = @date_lbl_bg_color.to_s
		cir.circle(@date_lbl_bg.rows/2, @date_lbl_bg.columns/2, 2, @date_lbl_bg.columns/2)
		cir.draw(@date_lbl_bg)

		cir = Draw.new
		cir.fill=@date_lbl_bg_color.to_s
		cir.stroke(@date_color.to_s)
		cir.stroke_width(12) #This is the width of the white stroke on the inner black circle.
		cir.circle(@date_lbl_bg.rows/2, @date_lbl_bg.columns/2, 24, @date_lbl_bg.columns/2) #The size of this smaller circle determines the stroke of black that surrounds the white
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
