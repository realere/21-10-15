require 'sinatra'
require 'pry-byebug'
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

  erb(:calculate)
end

get '/length_converter' do
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

  erb(:length_converter)
end

get '/sleeps_till_christmas' do
  @sleeps_till_christmas = Date.new(2015, 12, 24) - Date.now
  erb(:sleeps_till_christmas)
end

get '/age' do
  @age = today.year - dob.year - ((today.month > dob.month || (today.month == dob.month && today.day >= dob.day)) ? 0 : 1)
end
