module GoogleBooksApi
  def url_of_creating_from_id(googlebooksapi_id)
    "https://www.googleapis.com/books/v1/volumes/#{googlebooksapi_id}"
  end
  #  Google Books APIのIDから、APIのURLを取得する

  def url_of_searching_from_keyword(keyword)
    "https://www.googleapis.com/books/v1/volumes?q=#{keyword}&country=JP"
  end
  #  キーワードから、検索するAPIのURLを取得する

  def get_json_from_url(url)
    JSON.parse(Net::HTTP.get(URI.parse(Addressable::URI.encode(url))))
  end
  #  URLから、JSON文字列を取得し、JSONオブジェクトを構築する
end