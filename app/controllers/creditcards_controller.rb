class CreditcardsController < ApplicationController

  def create
    # @comment = Comment.create(text: comment_params[:text], tweet_id: comment_params[:tweet_id], user_id: current_user.id)
    @creditcard = Creditcard.create(credit_number: creditcard_params[:credit_number],
                                    limit_month: creditcard_params[:limit_month], 
                                    limit_year: creditcard_params[:limit_year],
                                    security_number: creditcard_params[:security_number],
                                    user_id: creditcard_params[:user_id])
    redirect_to "/users/#{current_user.id}/show_creditcard"
  end


  def destroy
    @creditcard = Creditcard.find(params[:id])
    @creditcard.destroy
    redirect_to "/users/#{current_user.id}/show_creditcard", notice: 'クレジットカード情報を削除しました'
  end

  private
  def creditcard_params
    params.permit(:credit_number, :limit_month, :limit_year, :security_number, :user_id)
  end

end

