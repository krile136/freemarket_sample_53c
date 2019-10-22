class CreditcardsController < ApplicationController

  def create
    @creditcard = Creditcard.new(creditcard_params)
    if @creditcard.save
      redirect_to show_creditcard_user_path(current_user.id), notice: 'クレジットカードを登録しました'
    else
      redirect_to new_creditcard_user_path(current_user.id), alert: '入力情報に間違いがあります'
    end
  end


  def destroy
    @creditcard = Creditcard.find(params[:id])
    if current_user.id == @creditcard.user_id
      if @creditcard.destroy
        redirect_to show_creditcard_user_path(current_user.id), notice: 'クレジットカード情報を削除しました'
      else
        redirect_to show_creditcard_user_path(current_user.id), alert: 'クレジットカード情報の削除に失敗しました'
      end
    else  
      redirect_to show_creditcard_user_path(current_user.id), alert: '不正なユーザーidです'
    end
  end

  private
  def creditcard_params
    params.permit(:credit_number, :limit_month, :limit_year, :security_number).merge(user_id: current_user.id)
  end
end

