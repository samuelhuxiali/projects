class PicturesController < ApplicationController
	before_action :authenticate_user!, except: [:index, :show]
	def index
		@pictures = Picture.all.order("created_at DESC")
	end

	def show
		@picture = Picture.find(params[:id])
	end

	def new
		@picture = current_user.pictures.build
	end

	def create
		@picture = current_user.pictures.build(pic_params)
		if @picture.save
			redirect_to root_path
		end
	end

	def edit
		@picture = Picture.find(params[:id])
	end

	def update
    @picture = Picture.find(params[:id])
    if @picture.update(pic_params)
      redirect_to "/pictures/#{@picture.id}"
    else
      render :edit
    end
	end

	private

	def pic_params
		params.require(:picture).permit(:title, :description, :image)
	end

	def find_picture
		@picture = Picture.find(params[:id])
	end
end
