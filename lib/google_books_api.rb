module GoogleBooksApi
  # googlebooksapiのidから、apiのurlを取得
  def url_of_creating_from_id(googlebooksapi_id)
    "https://www.googleapis.com/books/v1/volumes/#{googlebooksapi_id}"
  end
　
  # キーワードから、検索するapiのurlを取得する
  def url_of_searching_from_keyword(keyword)
    "https://www.googleapis.com/books/v1/volumes?q=#{keyword}&country=JP"
  end

  # urlから、json文字列を取得し、jsonオブジェクトを構築する
  def get_json_from_url(url)
    JSON.parse(Net::HTTP.get(URI.parse(Addressable::URI.encode(url))))
  end
end