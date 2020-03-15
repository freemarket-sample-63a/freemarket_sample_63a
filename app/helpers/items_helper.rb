module ItemsHelper
  def text_placeholder
    <<-"EOS".strip_heredoc
      商品の説明(必須1000文字以内)
      (色、素材、重さ、定価、注意点など)
      例)2010年頃に1万円で購入したジャケットです。ライトグレーで傷はありませ
      ん。あわせやすいのでおすすめです。
    EOS
  end

  def thousands_separator(price)
    # 現状はJPY固定。
    number_to_currency(price, unit: "￥", strip_insignificant_zeros: true)
  end

end
