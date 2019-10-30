class Location < Struct.new(:company, :address)
  def invoice
    "#{address}: #{amount_to_pay.format}"
  end

  def amount_to_pay
    Bill.for self
  end
end
