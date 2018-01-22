FraudResult = Struct.new(:is_fraudulent, :order_id)

class OrderChecker
  def initialize(orders)
    @orders = orders
  end

  def detect
    fraudulent_orders = filter_fraudulent_orders
    fraudulent_orders.map { |order| FraudResult.new(true, order.last.order_id) }
  end
end

class EmailChecker < OrderChecker
  protected

  def filter_fraudulent_orders
    @orders.combination(2).select do |original, target|
      original.deal_id == target.deal_id &&
        original.email == target.email &&
        original.credit_card != target.credit_card
    end
  end
end

class AddressChecker < OrderChecker
  protected

  def filter_fraudulent_orders
    @orders.combination(2).select do |original, target|
      original.deal_id == target.deal_id &&
        original.state == target.state &&
        original.zip_code == target.zip_code &&
        original.street == target.street &&
        original.city == target.city &&
        original.credit_card != target.credit_card
    end
  end
end
