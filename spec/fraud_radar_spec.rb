require 'spec_helper'

describe FraudRadar do
  it "should process the one line file" do
    file = File.read("spec/files/OneLineFile.txt")
    result = FraudRadar.new(file).check
    expect(result.size).to eql(0)
  end

  it "should process the two line file in which the second is fraudulent" do
    file = File.read("spec/files/TwoLines_FraudulentSecond.txt")
    result = FraudRadar.new(file).check
    expect(result.size).to eql(1)
    expect(result.first.is_fraudulent).to be true
    expect(result.first.order_id).to eql(2)
  end

  it "should process the three line file in which the second is fraudulent" do
    file = File.read("spec/files/ThreeLines_FraudulentSecond.txt")
    result = FraudRadar.new(file).check
    expect(result.size).to eql(1)
    expect(result.first.is_fraudulent).to be true
    expect(result.first.order_id).to eql(2)
  end

  it "should process the four line file in which more than one order is fraudulent" do
    file = File.read("spec/files/FourLines_MoreThanOneFraudulent.txt")
    result = FraudRadar.new(file).check
    expect(result.size).to eql(2)
  end

end
