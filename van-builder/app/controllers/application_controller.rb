require './config/environment'
require 'pry'

class ApplicationController < Sinatra::Base


  configure do
   set :public_folder, 'public'
   set :views, 'app/views'
   enable :sessions
   set :session_secret, "campervan"
  end

  get '/' do
    if logged_in?
      redirect to '/users/index'
    else
      erb :index
    end
  end

  helpers do
    def logged_in?
      !!current_user
    end

    def current_user
      @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
    end
  end

  def amount(number, options = {})
    if number.nil? && options[:nil_as_dash] != false
      ndash
    elsif number.zero? && options[:zero_as_dash]
      ndash
    elsif number.present?
      precision = options[:precision]
      if precision
        options[:minimum_precision] = precision
        options[:maximum_precision] = precision
      end
      number = number.round if options[:round]
      separator = options.fetch(:separator, I18n.t('number.format.separator'))
      delimiter = options.fetch(:delimiter, I18n.t('number.format.delimiter')).to_s
      minimum_precision = options[:minimum_precision] || 0
      str = number.to_s.sub(/\.0+\z/, "")
      str =~ /\A(\-?)(\d+)(?:\.(\d+))?\z/ or raise "Could not parse number: #{number}"
      sign = $1
      integer = $2
      fraction = ($3 || '')

      if options[:maximum_precision]
        fraction = fraction[0, options[:maximum_precision]] if options[:maximum_precision]
      end

      if minimum_precision > 0
        if fraction.length > 0 || minimum_precision > 0
          fraction = "#{fraction}#{'0' * [0, minimum_precision - fraction.length].max}"
        end
      end
      # the following two lines appear to be the most performant way to add a delimiter to every thousands place in the number
      integer_size = integer.size
      (1..((integer_size-1) / 3)).each {|x| integer[integer_size-x*3,0] = delimiter}
      str = integer.chomp(delimiter)

      # add fraction
      str << "#{separator}#{fraction}" if fraction.length > 0

      # restore sign
      str = "#{sign}#{str}"
      # add unit if given
      if options[:unit]
        unless options[:unit_separator] == false
          str << options.fetch(:unit_separator, nbsp)
        end
        str << options[:unit]
      end
      str
    end
  end

  def money_amount(number, options = {})
   amount(number, options.reverse_merge(:unit => '$', :nil_as_dash => true, :precision => 2))
 end
end
