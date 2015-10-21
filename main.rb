require 'pry-byebug'
require 'sinatra'
require 'sinatra/contrib/all' if development?

get '/' do
  erb(:home)
end

get '/about_us' do
  erb(:about_us)
end

get '/faqs' do
  erb(:faqs)
end

get '/calculate' do
  @first_number = params[:first_number].to_f
  @second_number = params[:second_number].to_f
  @operator = params[:operator]

  @result = case @operator
  when '+'
    @first_number + @second_number
  when '-'
    @first_number - @second_number
  when '*'
    @first_number * @second_number
  when '/'
    @first_number / @second_number
  end

  erb :calculate
end

get '/stuff_converter' do
  @first_unit = params[:first_unit]
  @second_unit = params[:second_unit]
  @input = params[:input].to_f

  @convert_to_centimeters = case @first_unit
  when 'centimeter'
    1
  when 'metre'
    100
  when 'kilometre'
    1000
  when 'inch'
    2.54
  when 'foot'
    30.48
  when 'yard'
    91.44
  when 'mile'
    160934
  end

  @convert_from_centimeters = case @second_unit
  when 'centimeter'
    1
  when 'metre'
    0.01
  when 'kilometre'
    0.001
  when 'inch'
    0.3937
  when 'foot'
    0.0328
  when 'yard'
    0.0109
  when 'mile'
    0.0000062137
  end

  if @input && @convert_from_centimeters && @convert_to_centimeters
    @result = (@input * @convert_to_centimeters)*@convert_from_centimeters
  end

  erb :length_converter
end

get '/sleeps_till_christmas' do
  christmas = Date.new(today.year, 12, 25)
  sleeps = (christmas - today).to_i

 case sleeps.to_i
  when 0
    "OMG! Check your stockings! Santa's been!!"
  when 1..10
    "Only #{sleeps} sleep#{'s' unless sleeps == 1} to go. It's getting close!"
  when 11..24
    "The advent calendar is getting a workout with only #{sleeps} sleeps to go."
  when 25..54
    "#{sleeps} sleeps until Christmas. Better get the cards for Australian friends written."
  when 55..100
    "#{sleeps} sleeps. Check back soon."
  when 101..250
    "You're too keen. I feel almost mean telling you there's #{sleeps} sleeps still left."
  when 251..366
    "It's hardly even Easter! There still #{sleeps} sleeps until Christmas."
  else
    "Oh noes! You missed it! Gotta wait until next year now :-("
  end
end

get '/age' do
 
   `clear`
 "Enter birth date in the following format - 'YYYY-MM-DD':"
  dob = get_date
  today = Date.today

  puts case
  when dob > today
    "That date is in the future, so not much use for calculating age from..."
  else
    age = today.year - dob.year - ((today.month > dob.month || (today.month == dob.month && today.day >= dob.day)) ? 0 : 1)

    case age
    when 0
      "Not even one-year-old yet"
    when 1..99
      "If that was your birthday, you would be #{age} year#{'s' if age > 1} old now."
    else
      "If that was your birthday, you would be #{age} years old now. And looking pretty good on it!"
    end
  end
end
