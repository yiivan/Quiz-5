FactoryGirl.define do
  factory :auction do
    title "MyString"
    details "MyText"
    ends_on "2016-05-30"
    reserve_price 1.5
    publish false
    user nil
  end
end
