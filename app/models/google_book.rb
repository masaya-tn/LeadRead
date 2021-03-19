require 'net/http'

class GoogleBook
  include ActiveModel::Model
  include ActiveModel::Attributes
  include ActiveModel::Validations

  attribute :googlebooksapi_id, :string
  attribute :authors
  attribute :image, :string
  attribute :published_at, :date
  attribute :title, :string

  validates :googlebooksapi_id, presence: true
  validates :title, presence: true

  class << self
    include GoogleBooksApi

    def new_from_item(item)
      @item = item
      @volume_info = @item['volumeInfo']
      new(
        googlebooksapi_id: @item['id'],
        authors: @volume_info['authors'],
        image: image_url,
        published_at: @volume_info['publishedDate'],
        title: @volume_info['title']
      )
    end

    def new_from_id(googlebooksapi_id)
      url = url_of_creating_from_id(googlebooksapi_id)
      item = get_json_from_url(url)
      new_from_item(item)
    end

    def search(keyword)
      url = url_of_searching_from_keyword(keyword)
      json = get_json_from_url(url)
      items = json['items']
      return [] unless items

      items.map do |item|
        GoogleBook.new_from_item(item)
      end
    end

    private

    def image_url
      @volume_info['imageLinks']['smallThumbnail'] if @volume_info['imageLinks'].present?
    end
  end

  def save
    return false unless valid?

    book = build_book
    return false unless book.valid?

    ActiveRecord::Base.transaction do
      book.remote_image_url = image if image.present?
      book.save
      authors.each.with_index do |author, index|
        author = book.authors.build(name: author)
        author.is_representation = index.zero?
        author.save
      end
    end
    true
  end

  def find_book_or_save
    if Book.find_by(googlebooksapi_id: googlebooksapi_id) || save
      Book.find_by(googlebooksapi_id: googlebooksapi_id)
    else
      false
    end
  end

  private

  def build_book
    Book.new(
      googlebooksapi_id: googlebooksapi_id,
      published_at: published_at,
      title: title
    )
  end
end
