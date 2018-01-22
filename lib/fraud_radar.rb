class FraudRadar
  def initialize(file)
    @file = file
  end

  def check
    orders = FileParser.new(@file).parse
    normalized_orders = OrderNormalizer.new(orders).normalize
    email_frauds = EmailChecker.new(normalized_orders).detect
    address_frauds = AddressChecker.new(normalized_orders).detect
    (email_frauds + address_frauds).uniq
  end
end
