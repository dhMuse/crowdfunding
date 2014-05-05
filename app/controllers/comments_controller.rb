class CommentsController < ApplicationController
	before_action :authenticate_user!
	before_action :find_commentable

	def create
		@comment = @commentable.comments.new(comment_params)
		if @comment.save
			redirect_to @commentable, notice: "Comment created"
		else
			render "/#{@commentable.class.name.underscore.pluralize}/show"
		end
	end

	private

	def comment_params
		params.require(:comment).permit(:body)
	end

	def find_commentable
		# resource, id = request.path.split("/")[1,2]
		# @commentable = resource.singularize.classify.constantize.find(id.to_i)
		if params[:campaign_id]
			@commentable = Campaign.friendly.find(params[:campaign_id])
		elsif params[:discussion_id]
			@commentable = Discussion.find(params[:discussion_id])
		end
	end

end
