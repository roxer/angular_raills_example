class TerritorialScope

  def initialize(params)
    @params=params
  end

  def generate_models
    limits_hash={} # przykładowy format: {'1' => Limit.new, '2' => Limit.new}
    master_area=MasterArea.create(code: 'EP', name: 'ma kota')
    master_area_name=''
    @params.each do |key, value| #przelatuję sobie przez wszystkie parametry
      if key.include? 'area_include_' #aby wykryć includy
        AreaContainer.create(area_id: master_area.id, areas_id: value, incl_excl: 1)
        master_area_name+=" + #{Area.find(value).code}"
        # jeśli już takiego includa się wykryje
        #to przelatuję przez wszystkie parametry znowu aby wykryć dla niego wszystkie limity
        generate_limits_hash(limits_hash)
      end
      if key.include? 'area_exclude_'
        AreaContainer.create(area_id: master_area.id, areas_id: value, incl_excl: 2)
        master_area_name+=" - #{Area.find(value).code}"
      end
    end
    master_area.name=master_area_name
    master_area.save!
    generate_limits(limits_hash, master_area)
  end

  #####################################################################################################################
  private

  def generate_limits(limits_hash, master_area)
    if limits_hash.blank?
      ZoneAreaLimit.create(zone_id: @params[:zone_id], area_id: master_area.id)
    else
      limits_hash.each do |limit_number, limit|
        limit.save!
        ZoneAreaLimit.create(zone_id: @params[:zone_id], area_id: master_area.id, limits_id: limit.id)
      end
    end
  end

  def generate_limits_hash(limits_hash)
    name_prefix="limit_name_include_"
    qty_prefix="limit_qty_include_"
    unit_prefix="limit_unit_include_"
    @params.each do |key2, value2|
      if key2.include? name_prefix
        # limit_number=key2.gsub(name_prefix, '')
        limit_number=get_limit_number(key2, name_prefix)
        key_in_hash=get_key(limit_number)
        limits_hash[key_in_hash]=Limit.new if limits_hash[key_in_hash].blank?
        limits_hash[key_in_hash].name=value2
      end
      if key2.include? qty_prefix
        # limit_number=key2.gsub(qty_prefix, '')
        limit_number=get_limit_number(key2, qty_prefix)
        key_in_hash=get_key(limit_number)
        limits_hash[key_in_hash]=Limit.new if limits_hash[key_in_hash].blank?
        limits_hash[key_in_hash].qty=value2
      end
      if key2.include? unit_prefix
        # limit_number=key2.gsub(unit_prefix, '')
        limit_number=get_limit_number(key2, unit_prefix)
        key_in_hash=get_key(limit_number)
        limits_hash[key_in_hash]=Limit.new if limits_hash[key_in_hash].blank?
        limits_hash[key_in_hash].unit=value2
      end
    end
  end

  def get_limit_number(key_str, prefix)
    key_str.gsub(prefix, '')
  end

  def get_key(limit_number)
    "_#{limit_number}"
  end

end