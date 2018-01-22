require 'spec_helper'

describe OrderNormalizer do
  let(:order) { Order.new(1, 1, "bugs@bunny.com", "123 Sesame St.", "New York", "NY", 10_011, 12_345_689_010) }

  it "normalizes the email with + and ." do
    order = Order.new(1, 1, "bu.gs+nosurname@bunny.com", "123 Sesame St.", "New York", "NY", 10_011, 12_345_689_010)
    expect(OrderNormalizer.new([order]).normalize.first.email).to eql("bugs@bunny.com")
  end

  it "normalizes the email without + and ." do
    expect(OrderNormalizer.new([order]).normalize.first.email).to eql("bugs@bunny.com")
  end

  it "normalizes the street" do
    expect(OrderNormalizer.new([order]).normalize.first.street).to eql("123 sesame street")
  end

  it "normalizes the state" do
    expect(OrderNormalizer.new([order]).normalize.first.state).to eql("new york")
  end
end
