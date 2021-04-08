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

  # new_from_idはGoogleBook.new_from_id('c1L4IzmUzicC')のようにクラスメソッドとして使いたいメソッドです。
  # クラスメソッドを定義する方法は他にもありますが、class << slefによるやり方が推奨なようです。
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
end
