class ApiController < ApplicationController
  skip_before_filter  :verify_authenticity_token
  rescue_from ActiveRecord::RecordNotFound, :with => :record_not_found
  rescue_from SQLite3::ConstraintException, :with => :cant_process
  def index
    render :text => `rake routes`
  end
  
  #user
  
  def user
    render :json => People::Engine.get_users(params[:id]).to_json
  end
  
  def new_user
    render :json => People::Engine.new_user(:username => params[:username])
  end
  
  def users
    if(params[:id])
      user 
    elsif( request.post? )
      new_user
    else
     render :json => People::Engine.all_users.to_json
    end
  end
  
  def users_books
    ownerships = Bookshelf::Engine.get_ownerships(:people_user_id => params[:id])
    render :json => Library::Engine.get_books(ownerships.map(&:library_book_id)).to_json
  end
  
  def user_gets_a_new_book
    ownership = Bookshelf::Engine.add_ownership(:people_user_id => params[:id], :library_book_id => params[:book_id])
    render :json => ownership.to_json
  end
  
  def user_tags_a_book    
    tagging = Tagit::Engine.tag(params[:id],People::User, params[:book_id], Library::Book, params[:tag])  
    render :json => tagging.to_json
  end
  
  def user_tags_a_user       
     tagging = Tagit::Engine.tag(params[:id],People::User, params[:user_id], People::User, params[:tag])  
     render :json => tagging.to_json
   end
   
  def tags_for_user
    tags = Tagit::Engine.get_tags(params[:id], People::User)   
    render :json => tags.to_json  
  end
  
  def users_tagged_with
    users_ids = Tagit::Engine.ids_tagged_with(params[:tag], People::User)
    users = People::Engine.get_users(users_ids)
    render :json => users.to_json
  end
  
  #book
  
  def book
    render :json => Library::Engine.get_books(params[:id]).to_json
  end
  
  def new_book
    render :json => Library::Engine.new_book(:title => params[:title])
  end
  
  def books
    if(params[:id])
      book 
    elsif( request.post? )
      new_book
    else
     render :json => Library::Engine.all_books.to_json
    end
  end  
  
  def tags_for_book
    tags = Tagit::Engine.get_tags(params[:id], Library::Book)   
    render :json => tags.to_json
  end
  
  def books_tagged_with
    book_ids = Tagit::Engine.ids_tagged_with(params[:tag], Library::Book)
    books = Library::Engine.get_books(book_ids)
    render :json => books.to_json
  end
  

  private
  
  def cant_process(error)
    render :json => {:error => error.message}, :status => 422
  end  
  
  def record_not_found(error)
    render :json => {:error => error.message}, :status => :not_found
  end 

end
