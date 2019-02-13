require 'rspec'
require 'dessert'

=begin
Instructions: implement all of the pending specs (the `it` statements without blocks)! Be sure to look over the solutions when you're done.
=end

describe Dessert do
  let(:cookie) {Dessert.new("cookie", 200, :chef)}
  let(:chef) {double("chef", name: "Anna")}


  describe "#initialize" do
    it "sets a type" do 
      expect(cookie.type).to eq("cookie")
    end 

    it "sets a quantity" do 
      expect(cookie.quantity).to eq(200)
    end 

    it "starts ingredients as an empty array" do 
      expect(cookie.ingredients).to eq([])  #be_empty
    end 

    it "raises an argument error when given a non-integer quantity" do 
      expect {Dessert.new("sugar", "a few", "Anna")}.to raise_error(ArgumentError)
    end 
  end

  describe "#add_ingredient" do
    it "adds an ingredient to the ingredients array" do 
      cookie.add_ingredient("oatmeal")
      expect(cookie.ingredients).to include("oatmeal")
    end
  end

  describe "#mix!" do
    it "shuffles the ingredient array" do 
      ingredients = ["sugar", "flour", "eggs", "chocolate chips"]

      ingredients.each do |ele| 
        cookie.add_ingredient(ele)
      end 

      expect(cookie.ingredients).to eq(ingredients)
      cookie.mix!
      expect(cookie.ingredients).not_to eq(ingredients)
      expect(cookie.ingredients.sort).to eq(ingredients.sort)
    end 
  end

  describe "#eat" do
    it "subtracts an amount from the quantity" do 
      cookie.eat(50)
      expect(cookie.quantity).to eq(150)
    end 

    it "raises an error if the amount is greater than the quantity" do 
      expect {cookie.eat(300)}.to raise_error("We don't have enough cookies!")
    end 
  end

  describe "#serve" do
    it "contains the titleized version of the chef's name" do 
      expect{Dessert.new("brownie", 20, "Anna")}.to eq("Anna has made 20 cookies!")
    end 
  end

  describe "#make_more" do
    it "calls bake on the dessert's chef with the dessert passed in"
  end
end
