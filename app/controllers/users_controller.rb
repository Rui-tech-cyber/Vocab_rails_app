class UsersController < ApplicationController
  before_action :authenticate_user!

  def my_page
    @user = current_user
    @exams = current_user.exams.reload.order(created_at: :desc)

  end
end
