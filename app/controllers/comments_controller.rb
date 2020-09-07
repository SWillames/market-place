class CommentsController < ApplicationController
    
    def create
        find_commentable()
        @comment = @commentable.comments.build(comment_params)
        @comment.save
        redirect_to @commentable
    end

    private 

    def comment_params
        params.require(:comment).permit(:body, :parent_id)
                                .merge(user_id: current_user.id)
    end  

    def find_commentable
        if params[:sale_id]
           @commentable = Sale.find_by_id(params[:sale_id])
        elsif params[:ad_id] 
           @commentable = Ad.find_by_id(params[:ad_id])
        end
    end
end