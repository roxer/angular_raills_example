require 'rest_client'

class EurotaxController < ApplicationController
  def brands# {{{
    ztype_code = params[:id]
    p = '{"conditions":[{"ztype_code":"'+ztype_code+'"}],"get_fields":[{"make_code":""},{"make_name":"asc"}]}'

    r = RestClient.post 'http://serwison.pl/mfind/eurotax/', p

    #require 'pry'; binding.pry;
    render text: r.body
  end# }}}

  def models# {{{
    make_name = params[:id]

    p = '{ "conditions": [ {
            "make_name": "'+make_name+'"
        }, { "ztype_code": "pkw:glw" } ],
      "get_fields": [ { "model_name": "asc" } ] }'

    r = RestClient.post 'http://serwison.pl/mfind/eurotax/', p

    #require 'pry'; binding.pry;
    #render text: r.body.sub(/conditions/, '[{"')
    render text: r.body
  end# }}}

  def fuels# {{{
    m = params[:brand]
    model = params[:model]
    p = '{ "conditions": [ { "make_name": "'+m+'"
        },
        {
            "ztype_code": "pkw:glw"
        },
        {
            "model_name": "'+model+'"
        }
    ],
    "get_fields": [ { "fuel_code": "", "fuel_name": "asc" } ] }'

    r = RestClient.post 'http://serwison.pl/mfind/eurotax/', p

    #require 'pry'; binding.pry;
    #render text: r.body.sub(/conditions/, '[{"')
    render text: r.body
  end# }}}

  def gears# {{{
    m = params[:brand]
    model = params[:model]
    fuel = params[:fuel]
    p = '{
    "conditions": [
        {
            "make_name": "'+m+'"
        },
        {
            "ztype_code": "pkw:glw"
        },
        {
            "model_name": "'+model+'"
        },
        {
            "fuel_code": "'+fuel+'"
        }
    ],
    "get_fields": [
        {
            "trans_code": "",
            "trans_name": "asc" } ] }'
    r = RestClient.post 'http://serwison.pl/mfind/eurotax/', p

    #require 'pry'; binding.pry;
    #render text: r.body.sub(/conditions/, '[{"')
    render text: r.body #.sub(/.*\[\{"/, '[{"')

  end# }}}

  def cars
    m = params[:brand]
    model = params[:model]
    fuel = params[:fuel]
    gear = params[:gear]
# {{{
    p = '{
    "conditions": [
        {
            "make_name": "'+m+'"
        },
        {
            "ztype_code": "pkw:glw"
        },
        {
            "model_name": "'+model+'"
        },
        {
            "fuel_code": "'+fuel+'"
        },
        {
            "trans_code": "'+gear+'"
        }
    ],
    "get_fields": {
        "0": {
            "model_full_name": "asc"
        },
        "1": {
            "begin_year": "asc"
        },
        "3": {
            "body_code": ""
        },
        "4": {
            "body_name": "asc"
        },
        "5": {
            "doors": "asc"
        },
        "6": {
            "engine_capacity": "asc"
        },
        "7": {
            "power_kw": "asc"
        },
        "8": {
            "power_hp": "asc"
        },
        "21": { "end_year": "asc" } } }'# }}}

    r = RestClient.post 'http://serwison.pl/mfind/eurotax/', p

    render text: r.body
  end
end
