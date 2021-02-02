class BooksController < ApplicationController
  before_action :authenticate_user!

  def index
    @book = Book.new
    @books = Book.all
    @user = current_user
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      flash[:success] = "successfully"
      redirect_to book_path(@book)
    else
      @books = Book.all
      @user = current_user
      render "index"
    end
  end

  def show
    @book = Book.find(params[:id])
    @book_new = Book.new
    @book_comment = BookComment.new
  end

  def edit
    @book = Book.find(params[:id])
    if @book.user == current_user
    else
      redirect_to books_path
    end
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      flash[:success] = "successfully"
      redirect_to book_path(@book)
    else
      render "edit"
    end
  end

  def destroy
    book = Book.find(params[:id])
    if book.user.id == current_user.id
      if book.destroy
        flash[:success] = "successfully"
        redirect_to books_path
      end
    end
  end

  private

  def book_params
    params.require(:book).permit(:title, :body)
  end

end
