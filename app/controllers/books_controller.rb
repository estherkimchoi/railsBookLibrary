class BooksController < ApplicationController
  before_action :find_book, only: [:show, :edit, :update, :destroy]

  def index
    if params[:category].blank? # if the category params passed is blank, don't need filltering
    @books = Book.all.order("created_at DESC")
    else
    @category_id = Category.find_by(name: params[:category]).id  # category = Fantasy
    @books = Book.where(:category_id => @category_id).order("created_at DESC")
    end
  end

  def show
  end

  def new
    @book = current_user.books.build  #build book from the current user
    @categories = Category.all.map{ |c| [c.name, c.id]}  #@categories is an array of arrays
  end
  def create
    @book = current_user.books.build(book_params)
    @book.category_id = params[:category_id] #category_id which is passed in when the form is submitted
     if @book.save #means when book is created
       redirect_to root_path
     else
       render 'new'
     end
  end

  def edit
      @categories = Category.all.map{ |c| [c.name, c.id]}  #when edit, is allow for access all the categories
  end
  def update
     @book.category_id = params[:category_id]
     if @book.update(book_params)  #if successfully updated
      redirect_to book_path(@book)
    else
      render 'edit'
    end
  end
  def destroy
    @book.destroy
    @book.book_img.purge
    redirect_to root_path    # becaue it is deleted and not exist anymore
  end

  private
    def book_params
      params.require(:book).permit(:title, :description, :author, :category_id, :book_img)
    end

    def find_book
      @book = Book.find(params[:id])
    end
end
