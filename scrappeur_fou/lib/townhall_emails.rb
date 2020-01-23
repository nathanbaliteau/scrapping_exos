require 'nokogiri'
require 'open-uri'

def get_townhall_email(townhall_url)
  page = Nokogiri::HTML(open("#{townhall_url}"))

  xpath_townhall_email = page.xpath('//td[contains(text(),"@")]')
  
  array_townhall_email = String.new
  xpath_townhall_email.each{|email| array_townhall_email = email.text}

  return array_townhall_email
end

def get_townhall_urls(department_url)
  page = Nokogiri::HTML(open(department_url))

  xpath_townhall_urls = page.xpath('//a[@class = "lientxt"]')

  array_townhall_urls = []
  xpath_townhall_urls.each do |townhall_url| 
    array_townhall_urls << "http://annuaire-des-mairies.com#{townhall_url['href'].delete_prefix('.')}"
  end
  
  return array_townhall_urls
end

def get_townhall_names(department_url)
  page = Nokogiri::HTML(open(department_url))

  xpath_townhall_names = page.xpath('//a[@class = "lientxt"]')

  array_townhall_names = []
  xpath_townhall_names.each do |townhall_name| 
    array_townhall_names << townhall_name.text
  end
  
  return array_townhall_names
end

def perform(department_url)
  final_array = []
  array_townhall_emails = []

  array_townhall_urls = get_townhall_urls(department_url)
  array_townhall_names = get_townhall_names(department_url)
  puts get_townhall_email(array_townhall_urls[0])
  
  array_townhall_urls.each do |townhall_url|
    array_townhall_emails << get_townhall_email(townhall_url)
  end

  hash_townhallname_email = [array_townhall_names, array_townhall_emails].transpose.to_h
  hash_townhallname_email.each do |key, value|
    h = Hash.new
    h[key] = value
    final_array << h
  end
end

puts perform("http://annuaire-des-mairies.com/val-d-oise.html")




 


  










