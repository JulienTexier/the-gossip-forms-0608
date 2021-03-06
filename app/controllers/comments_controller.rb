class CommentsController < ApplicationController
  def new
    @comment = Comment.new
  end
  def create
    @gossip = Gossip.find(params[:gossip_id])
    @comment = Comment.new(content: comment_params[:content], gossip: @gossip, user: current_user)
    if @comment.save
      flash[:success] = "Votre commentaire à bien été enregistré !"
    else
      flash[:error] = "Merci d'écrire quelque chose si tu veux écrire un commentaire! Enfin..."
    end
      redirect_back fallback_location: gossips_path
  end

  def edit
  	@comment = Comment.find(params[:id])
	end

	def update
		@comment = Comment.find(params[:id])
		if @comment.update(comment_params)
			flash[:success] = "Votre comment à bien été modifié !"
      redirect_to gossip_path(@comment.gossip.id)
    else
			render :edit
		end
	end	

  def destroy
    @comment = Comment.find(params[:id])
		@comment.destroy
		redirect_to gossip_path(@comment.gossip.id)
  end

  private 

  def comment_params
    params.require(:comment).permit(:content, :gossip_id, :id)
  end
end