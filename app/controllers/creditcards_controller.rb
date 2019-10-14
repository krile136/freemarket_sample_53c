class CreditcardsController < ApplicationController

  def create
    @creditcard = Creditcard.new(credit_number: creditcard_params[:credit_number],
                                    limit_month: creditcard_params[:limit_month], 
                                    limit_year: creditcard_params[:limit_year],
                                    security_number: creditcard_params[:security_number],
                                    user_id: creditcard_params[:user_id])
    if @creditcard.save
      redirect_to show_creditcard_user_path(current_user.id), notice: 'クレジットカードを登録しました'
    else
      redirect_to new_creditcard_user(current_user.id), alert: '入力情報に間違いがあります'
    end
  end


  def destroy
    @creditcard = Creditcard.find(params[:id])
    if @creditcard.destroy
      redirect_to show_creditcard_user_path(current_user.id), notice: 'クレジットカード情報を削除しました'
    else
      redirect_to show_creditcard_user_path(current_user.id), alert: 'クレジットカード情報の削除に失敗しました'
    end
  end

  private
  def creditcard_params
    params.permit(:credit_number, :limit_month, :limit_year, :security_number, :user_id)
  end

end

