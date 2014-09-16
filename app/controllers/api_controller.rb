class ApiController < ApplicationController
  skip_before_filter  :verify_authenticity_token
  rescue_from ActiveRecord::RecordNotFound, :with => :record_not_found
  rescue_from SQLite3::ConstraintException, :with => :cant_process
  def index
    render :text => `rake routes`
  end
  
  #user
  
  def user
    render :json => User.find(params[:id]).to_json
  end
  
  def new_user
    render :json => User.create(:username => params[:username])
  end
  
  def users
    if(params[:id])
      user 
    elsif( request.post? )
      new_user
    else
     render :json => User.all.to_json
    end
  end
  
  #book
  
  def book
    render :json => Book.find(params[:id]).to_json
  end
  
  def new_book
    render :json => Book.create(:title => params[:title])
  end
  
  def books
    if(params[:id])
      book 
    elsif( request.post? )
      new_book
    else
     render :json => Book.all.to_json
    end
  end  
  
  private
  
  def cant_process(error)
    render :json => {:error => error.message}, :status => 422
  end  
  
  def record_not_found(error)
    render :json => {:error => error.message}, :status => :not_found
  end 

end
