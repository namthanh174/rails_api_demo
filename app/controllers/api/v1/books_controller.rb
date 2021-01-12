class Api::V1::BooksController < ApplicationController
  before_action :load_book, only: :show

  def index
    @books = Book.all.includes(:reviews)
    books_rerializer = parse_json @books
    json_response "Index book successfully", true, {books: books_rerializer}, :ok
  end

  def show
    book_rerializer = parse_json @book
    json_response "Show book successfully", true, {book: book_rerializer}, :ok
  end

  private
  def load_book
    @book = Book.find_by id: params[:id]
    unless @book.present?
      json_response "Can not get book", false, {}, :not_found
    end
  end
end