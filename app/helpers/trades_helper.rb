module TradesHelper

  def card_present_and_addres_present?
    @default_card_information.present? && @address.present?
  end

end
