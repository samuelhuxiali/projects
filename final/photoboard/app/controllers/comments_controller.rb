class CommentsController < ApplicationController
	before_action :authenticate_user!
	def create
		@picture = Picture.find(params[:picture_id])

		@comment = @picture.comments.create(params[:comment].permit(:name, :body))
		redirect_to picture_path(@picture)
	end

end
