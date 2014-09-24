class ApiController < ApplicationController
  skip_before_filter  :verify_authenticity_token
  rescue_from ActiveRecord::RecordNotFound, :with => :record_not_found
  rescue_from SQLite3::ConstraintException, :with => :cant_process
  def index
    render :text => `rake routes`
  end
  
  #user
  
  def user
    render :json => People::User.find(params[:id]).to_json
  end
  
  def new_user
    render :json => People::User.create(:username => params[:username])
  end
  
  def users
    if(params[:id])
      user 
    elsif( request.post? )
      new_user
    else
     render :json => People::User.all.to_json
    end
  end
  
  def users_books
    render :json => Bookshelf::Ownership.where(:people_user_id => params[:id]).map(&:library_book).to_json
  end
  
  def user_gets_a_new_book
    user = People::User.find(params[:id])
    book = Library::Book.find(params[:book_id])
    
    ownership = Bookshelf::Ownership.create(:people_user => user, :library_book => book)
    render :json => ownership.to_json
  end
  
  def user_tags_a_book
    user = People::User.find(params[:id])
    book = Library::Book.find(params[:book_id])
    render :json => user.tag(book, :with => params[:tag], :on => "tags").to_json
  end
  
  def user_tags_a_user
     user = People::User.find(params[:id])
     other_user = People::User.find(params[:user_id])
     tags = other_user.owner_tags_on(user,"tags").map(&:name)
     tags << params[:tag]
     render :json => user.tag(other_user, :with => tags, :on => "tags").to_json
   end
   
  def tags_for_user
    user = People::User.find(params[:id])
    render :json => user.tags.to_a.uniq.to_json
  end
  
  def users_tagged_with
    users = People::User.tagged_with(params[:tag]).uniq
    render :json => users.to_json
  end
  
  #book
  
  def book
    render :json => Library::Book.find(params[:id]).to_json
  end
  
  def new_book
    render :json => Library::Book.create(:title => params[:title])
  end
  
  def books
    if(params[:id])
      book 
    elsif( request.post? )
      new_book
    else
     render :json => Library::Book.all.to_json
    end
  end  
  
  def tags_for_book
    book = Library::Book.find(params[:id])
    render :json =>   book.tags.to_a.uniq.to_json
  end
  
  def books_tagged_with
    books = Library::Book.tagged_with(params[:tag]).uniq
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
