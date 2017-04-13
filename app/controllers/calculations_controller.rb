class CalculationsController < ApplicationController

  def word_count
    @text = params[:user_text]
    @special_word = params[:user_word]

   sentence = @text.downcase.split
   search_key = @special_word.downcase.split

   sentence_length = 0
   search_count = 0

   sentence.each do |word|
      sentence_length += word.length

      search_key.each do |key|
         if key == word.gsub(/[^a-z0-9\s]/i, "")
            search_count += 1
         end
      end
   end

    @word_count = @text.split.count

    @character_count_with_spaces = @text.length

    @character_count_without_spaces = sentence_length

    @occurrences = search_count

    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("word_count.html.erb")
  end

  def loan_payment
    @apr = params[:annual_percentage_rate].to_f
    @years = params[:number_of_years].to_i
    @principal = params[:principal_value].to_f

   monthly_interest = (@apr/12.0/100)
   months = (@years*12)

   payment = ((@principal*monthly_interest)/(1-(1+monthly_interest)**(-months)))

    @monthly_payment = payment

    render("loan_payment.html.erb")
  end

  def time_between
    @starting = Chronic.parse(params[:starting_time])
    @ending = Chronic.parse(params[:ending_time])

    # ================================================================================
    # Your code goes below.
    # The start time is in the Time @starting.
    # The end time is in the Time @ending.
    # Note: Ruby stores Times in terms of seconds since Jan 1, 1970.
    #   So if you subtract one time from another, you will get an integer
    #   number of seconds as a result.
    # ================================================================================

    seconds = @ending-@starting
    minutes = (seconds/60.0)
    hours = (minutes/60.0)
    days = (hours/24.0)
    weeks = (days/7.0)
    years = (weeks/52.0)

    @seconds = seconds
    @minutes = minutes
    @hours = hours
    @days = days
    @weeks = weeks
    @years = years

    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("time_between.html.erb")
  end

  def descriptive_statistics
    @numbers = params[:list_of_numbers].gsub(',', '').split.map(&:to_f)

   

    @sorted_numbers = "Replace this string with your answer."

    @count = "Replace this string with your answer."

    @minimum = "Replace this string with your answer."

    @maximum = "Replace this string with your answer."

    @range = "Replace this string with your answer."

    @median = "Replace this string with your answer."

    @sum = "Replace this string with your answer."

    @mean = "Replace this string with your answer."

    @variance = "Replace this string with your answer."

    @standard_deviation = "Replace this string with your answer."

    @mode = "Replace this string with your answer."

    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("descriptive_statistics.html.erb")
  end
end
