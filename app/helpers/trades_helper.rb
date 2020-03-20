module TradesHelper

  # 購入者チェック（カード情報と住所があれば購入できる）
  def card_present_and_addres_present?
    @default_card_information.present? && @address.present?
  end
  
  # 売約済みチェック（tradeレコードがあれば売約済み）
  def trade_submited?
    @trade.present?
  end
end
