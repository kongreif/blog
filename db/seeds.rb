# frozen_string_literal: true

puts 'Start seeding'
puts '-----------------------------'
puts 'Remove old data'

Post.destroy_all

puts 'Adding posts'

5.times do
  content = <<~TEXT
    #{Faker::Lorem.paragraphs(number: (3..9).to_a.sample).join(' ')}\n
    ```ruby
    def test_function(num1, num2)
      num1 + num2
    end
    ```
    This is some `inline code` to test.
    ## #{Faker::Lorem.words(number: (1..9).to_a.sample).join(' ')}
    #{Faker::Lorem.paragraphs(number: (3..9).to_a.sample).join(' ')}\n
  TEXT

  post = Post.create(title: Faker::Lorem.words(number: (1..9).to_a.sample).join(' '), content:, excerpt: Faker::Lorem.paragraph)
  puts "Add '#{post.title}' post"
end

puts '-----------------------------'
puts 'Finished seeding'
