class BooksController < ApplicationController
  def search
    @search_form = SearchBooksForm.new(search_books_params)
    books = GoogleBook.search(@search_form.keyword)
    @books = Kaminari.paginate_array(books).page(params[:page])
  end

  private

  def search_books_params
    params.fetch(:q, keyword: '').permit(:keyword)
  end
end
