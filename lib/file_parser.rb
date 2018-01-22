require 'csv'

Order = Struct.new(:order_id, :deal_id, :email, :street, :city, :state, :zip_code, :credit_card)

class FileParser
  def initialize(file)
    @file = file
  end

  def parse
    file_parsed = CSV.parse(@file)
    file_parsed.map do |items|
      Order.new(*items)
    end
  end
end
