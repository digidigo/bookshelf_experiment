class ApiController < ApplicationController
  skip_before_filter  :verify_authenticity_token
  rescue_from ActiveRecord::RecordNotFound, :with => :record_not_found
  rescue_from SQLite3::ConstraintException, :with => :cant_process
  def index
    render :text => `rake routes`
  end
  
  # Everything in here is straight active record. And as such is tightly coupled to 
  # the database schema. This is one of the abstraction leaks that causes us to 
  # consider a different approach.
  
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
  
  def users_books
    # Notice here books is a method on the User object.
    # This violates single responsibility. The User model
    # starts to know about books. 
    render :json => User.find(params[:id]).books.to_json
  end
  
  def user_gets_a_new_book
    render :json => User.find(params[:id]).books << Book.find(params[:book_id])
  end
  
  def user_tags_a_book
    user = User.find(params[:id])
    book = Book.find(params[:book_id])
    #acts as taggable adds methods to the user object and works with other instances.
    render :json => user.tag(book, :with => params[:tag], :on => "tags").to_json
  end
  
  def user_tags_a_user
     user = User.find(params[:id])
     other_user = User.find(params[:user_id])
     # Couldn't figure out now to have acts as taggable simply add tags
     # so after looking into the acts ad taggable code we find out how 
     # to add tags.
     tags = other_user.owner_tags_on(user,"tags").map(&:name)
     tags << params[:tag]
     render :json => user.tag(other_user, :with => tags, :on => "tags").to_json
   end
   
  def tags_for_user
    user = User.find(params[:id])
    # strange that we had to do a uniq here. Definitely calls for further 
    # encapsulation.
    render :json => user.tags.to_a.uniq.to_json
  end
  
  def users_tagged_with
    # Another use of uniq. And an example of the User class
    # exposing the tagging API, breaking single responsibility.
    users = User.tagged_with(params[:tag]).uniq
    render :json => users.to_json
  end
  
  #book
  #  Book is identical to user.
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
  
  def tags_for_book
    book = Book.find(params[:id])
    render :json =>   book.tags.to_a.uniq.to_json
  end
  
  def books_tagged_with
    books = Book.tagged_with(params[:tag]).uniq
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
