FactoryBot.define do
  factory :user do
    transient do
      person { Gimei.name }
   end
    nickname              { Faker::Name.name}
    email                 { Faker::Internet.free_email}
    password              { 'Abc123' }
    password_confirmation { password }
    family_name           { person.last.kanji }
    given_name            { person.first.kanji }
    family_name_kana      { person.last.katakana }
    given_name_kana       { person.first.katakana }
    birthday              { Faker::Date.between(from: Date.new(1930, 1, 1), to: Date.new(2018, 1, 1)) }
  end
end