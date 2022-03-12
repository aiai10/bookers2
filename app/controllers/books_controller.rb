class BooksController < ApplicationController
  before_action :ensure_current_user, {only: [:edit]}

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    @books = Book.all
    if @book.save
      flash[:create]="You have created book successfully."
      redirect_to book_path(@book.id)
    else
      @user = current_user
      render "index"
    end
  end

  def index
    @book = Book.new
    @user = current_user
    @books = Book.all
  end

  def show
    @new_book = Book.new
    @book = Book.find(params[:id])
    @user = @book.user
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      flash[:update]="You have updated book successfully."
       redirect_to book_path(@book.id)
    else
        render "edit"
    end
  end

  def destroy
    book = Book.find(params[:id])
    book.destroy
    redirect_to books_path
  end

  private
  def book_params
    params.require(:book).permit(:title, :body)
  end

  def ensure_current_user
    @book = Book.find(params[:id])
    @user = @book.user

    if current_user.id != @user.id
      redirect_to books_path
    end
  end
end
