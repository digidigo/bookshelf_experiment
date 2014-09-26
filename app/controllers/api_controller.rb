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
    
    tag = ActsAsTaggableOn::Tag.where(:name => params[:tag]).first_or_create
    tagging = ActsAsTaggableOn::Tagging.create(:tagger => user, :taggable => book, :tag => tag , :context => "tags")
    render :json => tagging.to_json
  end
  
  def user_tags_a_user
     user = People::User.find(params[:id])
     other_user = People::User.find(params[:user_id]) 
       
     tag = ActsAsTaggableOn::Tag.where(:name => params[:tag]).first_or_create
     tagging = ActsAsTaggableOn::Tagging.create(:tagger => user, :taggable => other_user, :tag => tag , :context => "tags")
     render :json => tagging.to_json
   end
   
  def tags_for_user
    user = People::User.find(params[:id])
    taggings = ActsAsTaggableOn::Tagging.where(:taggable => user)
    render :json => taggings.map(&:tag).to_a.uniq.to_json
  end
  
  def users_tagged_with
    tag = ActsAsTaggableOn::Tag.where(:name => params[:tag]).first
    taggings = ActsAsTaggableOn::Tagging.where(:taggable_type => People::User, :tag => tag).all
    users = People::User.find(taggings.map(&:taggable_id))
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
    taggings = ActsAsTaggableOn::Tagging.where(:taggable => book).all
    render :json => taggings.map(&:tag).to_a.uniq.to_json
  end
  
  def books_tagged_with
    tag = ActsAsTaggableOn::Tag.where(:name => params[:tag]).first
    taggings = ActsAsTaggableOn::Tagging.where(:taggable_type => Library::Book, :tag => tag).all
    books = Library::Book.find(taggings.map(&:taggable_id))
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
