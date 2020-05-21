class RelationshipsController < ApplicationController
  def create
    @follow = current_user.active_relationships.build(follower_id: params[:user_id])
    @follow.save
    # redirect_to user_path
    redirect_back(fallback_location: user_relationships_path)
  end

  def destroy
    @follow = current_user.active_relationships.find_by(follower_id: params[:user_id])
    @follow.destroy
    # redirect_to root_path
    redirect_back(fallback_location: user_relationships_path)
  end
end