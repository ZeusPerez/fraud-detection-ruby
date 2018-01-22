require 'spec_helper'

describe FileParser do
  it "parses the file" do
    file = File.read("spec/files/FourLines_MoreThanOneFraudulent.txt")
    orders = FileParser.new(file).parse
    expect(orders.size).to eql(4)
    expect(orders).to all(be_a(Order))
  end
end
