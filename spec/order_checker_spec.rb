require 'spec_helper'

describe EmailChecker do
  let(:order) { Order.new(1, 1, "bugs@bunny.com", "123 Sesame St.", "New York", "NY", 10_011, 12_345_689_010) }

  it "returns one fraud result" do
    other_order = Order.new(2, 1, "bugs@bunny.com", "123 Sesame St.", "Illinois", "IL", 10_011, 12_345_689_011)
    fraud_results = EmailChecker.new([order, other_order]).detect
    expect(fraud_results.first.is_fraudulent).to be true
    expect(fraud_results.first.order_id).to eql(2)
  end

  it "doesn't return fraud results" do
    other_order = Order.new(2, 1, "bugs@bunny.com", "123 Sesame St.", "Illinois", "IL", 10_011, 12_345_689_010)
    fraud_results = EmailChecker.new([order, other_order]).detect
    expect(fraud_results).to be_empty
  end
end

describe AddressChecker do
  let(:order) { Order.new(1, 1, "bugs@bunny.com", "123 Sesame St.", "New York", "NY", 10_011, 12_345_689_010) }

  it "returns one fraud result" do
    other_order = Order.new(2, 1, "roger@rabbit.com", "123 Sesame St.", "New York", "NY", 10_011, 12_345_689_011)
    fraud_results = AddressChecker.new([order, other_order]).detect
    expect(fraud_results.first.is_fraudulent).to be true
    expect(fraud_results.first.order_id).to eql(2)
  end

  it "doesn't return fraud results" do
    other_order = Order.new(2, 1, "roger@rabbit.com", "123 Sesame St.", "New York", "NY", 10_011, 12_345_689_010)
    fraud_results = AddressChecker.new([order, other_order]).detect
    expect(fraud_results).to be_empty
  end
end
