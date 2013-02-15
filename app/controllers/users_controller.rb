class UsersController < ApplicationController


  def show
    @user = User.find(params[:id])
    respond_to do |format|
      if @user
          format.html # show.html.erb
      end
    end
  end

  def new
     @user = User.new
     # @user.data_points.build
     respond_to do |format|
       format.html # new.html.erb
       format.json { render json: @user }
     end
  end

  def create
    @user = User.new(params[:user])
    respond_to do |format|
      if @user.save
        format.html # new.html.erb
        format.json { render json: @user }
      else
        format.html { render action: "new" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

end
