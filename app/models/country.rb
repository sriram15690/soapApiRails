class Country < ActiveRecord::Base
  
  def self.get_countries_data
    client = Savon.client do
      wsdl "http://www.webservicex.net/country.asmx?WSDL"
    end
    puts client.operations
    response = client.call(:get_countries,:message => {}).body[:get_countries_response][:get_countries_result]
    xml_doc  =Nokogiri::XML(response)
    all_countries = []
    xml_doc.xpath("//Table").each do |country|
      all_countries.push country.content.strip
    end
    puts all_countries
    return all_countries
  end
  
  def self.push_api_country_list_to_db
    client = Savon.client do
      wsdl "http://www.webservicex.net/country.asmx?WSDL"
    end
    puts client.operations
    response = client.call(:get_countries,:message => {}).body[:get_countries_response][:get_countries_result]
    xml_doc  =Nokogiri::XML(response)
    xml_doc.xpath("//Table").each do |country|
      new_country = Country.new(:name => country.content.strip)
      new_country.save! 
    end
    puts Country.pluck(:name)
    puts "Finished pushing"
  end

end
