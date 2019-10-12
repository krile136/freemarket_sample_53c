class CreditcardsController < ApplicationController
  def destroy
    @creditcard = Creditcard.find(params[:id])
    @creditcard.destroy
    redirect_to "/users/#{current_user.id}/registrate_creditcard", notice: 'クレジットカード情報を削除しました'
  end

end
