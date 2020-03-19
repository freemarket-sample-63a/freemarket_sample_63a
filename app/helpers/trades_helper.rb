module TradesHelper

  # 購入者チェック（カード情報と住所があれば購入できる）
  def card_present_and_addres_present?(card, address)
    card.present? && address.present?
  end
  # 売約済みチェック（tradeレコードがあれば売約済み）
  def trade_submited?(trade)
    trade.present?
  end
end
