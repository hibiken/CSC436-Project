FactoryGirl.define do
  factory :post do
    title { FFaker::HipsterIpsum.phrase }
    content { FFaker::HipsterIpsum.paragraph }
    user
  end
end
